import os
import sys
import struct
import json
from time import perf_counter


FAT_MAGIC = 0xCAFEBABE
FAT_CIGAM = 0xBEBAFECA
FAT_MAGIC_64 = 0xCAFEBABF
FAT_CIGAM_64 = 0xBFBAFECA

MH_MAGIC = 0xFEEDFACE
MH_CIGAM = 0xCEFAEDFE
MH_MAGIC_64 = 0xFEEDFACF
MH_CIGAM_64 = 0xCFFAEDFE

MH_EXECUTE = 0x00000002

LC_SEGMENT_64 = 0x19
LC_DYLD_INFO_ONLY = 0x22
LC_SYMTAB = 0x02

N_OSO = 0x66

FAKE_PATH = b'fake/path'

total_oso_entries = 0

def read_byte(f):
    return struct.unpack("<B", f.read(1))[0]

def read_2_bytes(f):
    return struct.unpack("<H", f.read(2))[0]

def read_4_bytes(f):
    return struct.unpack("<I", f.read(4))[0]

def read_8_bytes(f):
    return struct.unpack("<Q", f.read(8))[0]

def read_segment_name(f):
    return f.read(16).decode()

def read_symbol_index(f):
    return f.read(4).decode()

def read_string(strtab, start):
    end = start
    while strtab[end] != 0x0:
        end += 1
    return strtab[start:end]

def write_fake_path(f, orig, mapping):
    f.seek(orig)
    for offset, oso in mapping.items():
        f.seek(offset, 1)
        str_len = len(oso)
        buffer = FAKE_PATH + b' ' * (str_len - len(FAKE_PATH))
        f.write(buffer)
        f.seek(orig)
    

def load_header(f, offset):
    f.seek(offset)
    magic = struct.unpack("<I", f.read(4))[0]
    # print("header: ", hex(magic))
    is64bit = False
    if magic == MH_MAGIC_64:
        is64bit = True
    cpu_type = read_4_bytes(f)
    # print("cpu_type: ", hex(cpu_type))
    cpu_sub_type = read_4_bytes(f)
    # print("cpu_sub_type: ", hex(cpu_sub_type))
    file_type = read_4_bytes(f)
    # print("file_type: ", hex(file_type))
    cmd_cnt = read_4_bytes(f)
    # print("load_cmd_cnt: ", cmd_cnt)
    cmd_size = read_4_bytes(f)
    # print("cmd_size: ", cmd_size)
    flags = read_4_bytes(f)
    # print("flags: ", hex(flags))
    if is64bit:
        reserved = read_4_bytes(f)
        # print("reserved: ", reserved)
    
    return f.tell(), cmd_cnt


def load_commands(f, offset, cnt):
    """
    The OSO entries are identified in segments named __LINKEDIT.
    If no segment is found with that name, there is nothing to scrub.
    """
    f.seek(offset)
    for _ in range(cnt):
        # print("--------------")
        pos = f.tell()
        # print("pos: ", pos)
        cmd = read_4_bytes(f)
        # print("cmd: ", hex(cmd))
        size = read_4_bytes(f)
        # print("size: ", size)
        if cmd == LC_SEGMENT_64:
            name = read_segment_name(f)
            # print("name: ", name)
            if "LINKEDIT" in name:
                vm_address = read_8_bytes(f)
                # print("vm_address: ", vm_address)
                vm_size = read_8_bytes(f)
                # print("vm_size: ", vm_size)
                file_offset = read_8_bytes(f)
                # print("file_offset: ", file_offset)
                file_size = read_8_bytes(f)
                # print("file_size: ", file_size)
                maximum_vm_protection = read_4_bytes(f)
                # print("maximum_vm_protection: ", hex(maximum_vm_protection))
                initial_vm_protection = read_4_bytes(f)
                # print("initial_vm_protection: ", hex(initial_vm_protection))
                sections = read_4_bytes(f)
                # print("numer of sectinos: ", sections)
                flags = read_4_bytes(f)
                # print("flags: ", flags)
                found_link_edit = True
                continue
        elif cmd == LC_SYMTAB:
            symtab_offset = read_4_bytes(f)
            # print("symtab_offset: ", symtab_offset)
            symtab_count = read_4_bytes(f)
            # print("symtab_count: ", symtab_count)
            strtab_offset = read_4_bytes(f)
            # print("strtab_offset: ", strtab_offset)
            strtab_size = read_4_bytes(f)
            # print("strtab_size: ", strtab_size)
            found_symtab = True
            continue
        f.seek(pos)
        f.seek(size, 1)

    if not found_link_edit:
        print("No LINKEDIT found!")
        return
    
    if not found_symtab:
        print("No SymTab found!")
        return

    if strtab_size == 0 or symtab_count == 0:
        print("No symtab or string table found!")
        return
    
    # load string table
    f.seek(0)
    f.seek(strtab_offset)
    strtable = f.read(strtab_size)    
    
    # print("------------")
    # parse string tables
    f.seek(0)
    # move to string table offest
    f.seek(symtab_offset)
    pos = f.tell()
    # symtab_entry_size = 4 + 1 + 1 + 2 + 8
    ret = {}
    for i in range(symtab_count):
        """
        // Each LC_SYMTAB entry consists of the following fields:
        // - String Index: 4 bytes (offset into the string table)
        // - Type: 1 byte
        // - Section: 1 byte
        // - Description: 2 bytes
        // - Value: 8 bytes on 64bit, 4 bytes on 32bit
        """
        strtab_index = read_4_bytes(f)
        sym_type = read_byte(f)
        section_index = read_byte(f)
        desc = read_2_bytes(f)
        value = read_8_bytes(f)
        if sym_type == N_OSO:
            # print("strtab_index: ", hex(strtab_index))    
            # print("type: ", hex(sym_type))
            # print("section_index: ", hex(section_index))
            # print("desc: ", hex(desc))
            # print("value: ", hex(value))
            oso_str = read_string(strtable, strtab_index)
            # print("oso_str: ", oso_str)
            ret[strtab_index] = oso_str
    global total_oso_entries
    total_oso_entries += len(ret)
    return strtab_offset, ret


def scrub(path):
    start = perf_counter()
    with open(path, "r+b") as f:
        macho_type = struct.unpack(">I", f.read(4))[0]
        if macho_type in (FAT_MAGIC, FAT_MAGIC_64):
            assert(False)
        f.seek(0)
        pos, cnt = load_header(f, 0,)
        offset, mapping = load_commands(f, pos, cnt)
        write_fake_path(f, offset, mapping)
    end = perf_counter()
    elaspsed = end - start
    print(f"scrubbing {path} took: {elaspsed: .3f}s. ")
    

def main():
    app_dir  = sys.argv[1]
    exe_name = sys.argv[2]
    json_file_path = sys.argv[3]
    exe_path = app_dir + "/" + exe_name
    framework_path = app_dir + "/Frameworks"
    binaries = [exe_path]
    for fmk_path in os.listdir(framework_path):
        dylib_name = fmk_path.split(".")[0]
        dylib_path = os.path.join(framework_path, fmk_path, dylib_name)
        binaries.append(dylib_path)
    
    start = perf_counter()
    for path in binaries:
        scrub(path)
    end = perf_counter()
    elaspsed = end - start
    print(f"total oso entry: {total_oso_entries}")
    print(f"scrub {exe_name} took: {elaspsed: .3f}s.")
    

if __name__ == "__main__":
    main()