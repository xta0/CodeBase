import os
from pickle import OBJ
import sys
import subprocess


arvr = 0
fbobjc = 0
xplat = 0
third_party = 0
unknown = 0
def count_repo(item):
    global xplat
    global fbobjc
    global third_party
    global unknown
    global arvr
    if "xplat" in item:
        print(item)
        xplat += 1
    elif "fbobjc" in item:
        fbobjc += 1
    elif "arvr" in item:
        arvr += 1
    elif "third_party" in item:
        third_party += 1
    else:
        unknown += 1

def kb_to_gb(size):
    return f"{ float(size) / 1024 / 1024 } GB"

def run_cmd(cmd):
    try:
        return subprocess.check_output(cmd, shell=True).decode(sys.stdout.encoding).strip()
    except Exception as e:
        print(e)

def collect_binaries(app_dir, exe_name):
    exe_path = app_dir + "/" + exe_name
    framework_path = app_dir + "/Frameworks"
    binaries = [exe_path]
    for fmk_path in os.listdir(framework_path):
        dylib_name = fmk_path.split(".")[0]
        dylib_path = os.path.join(framework_path, fmk_path, dylib_name)
        binaries.append(dylib_path)
    return binaries


cnt=0
def collect_object_files(binaries):
    mappings = {}
    object_files = set()
    for binary in binaries:
        print("[DEBUG] binary: ", binary)
        cmd = f"dsymutil -s {binary} | grep '(N_OSO'"
        results = run_cmd(cmd)
        if results:
            results = results.strip().split("\n")
        else:
            print("[DEBUG] invalid binary: ", binary)
            continue
        for item in results:
            item = item.split(" ")[-1][1:-1]
            if item.endswith(".o"):
                count_repo(item)
                object_files.add(item)
                continue
            if item == "fake/path":
                global cnt
                cnt += 1
                continue
            item = item.split("(")
            if len(item) != 2:
                print("[DEBUG] len(item) != 2")
                print("[DEBUG] ", item)
                continue
            static_lib, object_file = item
            object_file = object_file[:-1]
            if static_lib in mappings:
                mappings[static_lib].add(object_file)
            else:
                tmp = set()
                tmp.add(object_file)
                mappings[static_lib] = tmp
    return mappings, object_files


def check_static_libs(mappings):
    static_libs = mappings.keys()
    total_object_files = 0
    total_dwarf_size = 0
    total_object_file_size = 0

    global xplat
    global fbobjc
    global third_party
    global unknown

    for lib_path in static_libs:
        # check number of object files
        used_object_files = mappings[lib_path]
        total_object_files += len(used_object_files)
        # calculate dwarf size
        cmd = f"dwarfdump {lib_path} --show-section-sizes"
        results = run_cmd(cmd).split("\n")
        found = False
        for item in results:
            if "file:" in item:
                count_repo(item)
                object_file = item.split("(")[1][:-1]
                if object_file in used_object_files:
                    found = True
            if item.strip().startswith("Total Size"):
                if found == False:
                    continue
                size_in_bytes = int(item.strip().split(" ")[2])
                total_dwarf_size += float(size_in_bytes) / 1024
            if item.strip().startswith("Total File Size"):
                if found == False:
                    continue
                size_in_bytes = int(item.strip().split(" ")[-1])
                total_object_file_size += float(size_in_bytes) / 1024
                found = False
    return total_object_files, total_dwarf_size, total_object_file_size


from time import perf_counter
def create_dsym(app_dir, exe_name):
    exe_path = app_dir + "/" + exe_name
    framework_path = app_dir + "/Frameworks"
    binaries = [exe_path]
    for fmk_path in os.listdir(framework_path):
        dylib_name = fmk_path.split(".")[0]
        dylib_path = os.path.join(framework_path, fmk_path, dylib_name)
        binaries.append(dylib_path)

    sz_in_kb = 0
    start = perf_counter()
    for path in binaries:
        cmd = f"dsymutil {path}"
        run_cmd(cmd)
        # calculate size
        dsym_file = path + ".dSYM"
        if os.path.exists(dsym_file):
            print("[DEBUG] found dSYM: ", dsym_file)
            dwarf_file = dsym_file + "/Contents/Resources/DWARF"
            cmd = f"du -k {dwarf_file}" + " | awk '{print $1}'"
            size = run_cmd(cmd)
            print("[DEBUG] size: ", size)
            sz_in_kb += int(size)
    end = perf_counter()
    elaspsed = end - start
    print("generating dSYM took: {0: .6f}s to run.".format(elaspsed))
    print("dSYM size in total: ", kb_to_gb(sz_in_kb))


def main():
    app_dir = os.path.abspath(sys.argv[1])
    exe_path = sys.argv[2]
    if len(sys.argv) > 3 and sys.argv[3] == "dsym":
        create_dsym(app_dir, exe_path)
        return
    binaries = collect_binaries(app_dir, exe_path)
    mappings, object_files = collect_object_files(binaries)
    print("fake_path: ", cnt)
    print("#binary_object_files: ", len(object_files))
    print("#static libs: ", len(mappings.keys()))
    obj, dwarf_size, obj_size = check_static_libs(mappings)
    print("#object files: ", obj + len(object_files))
    print("object file size: ", kb_to_gb(obj_size))
    print("dwarf size: ", kb_to_gb(dwarf_size))
    print("xplat: ", xplat)
    print("fbobjc: ", fbobjc)
    print("arvr: ", arvr)
    print("third-party: ", third_party)
    print("unknown: ", unknown)




if __name__ == "__main__":
    main()
