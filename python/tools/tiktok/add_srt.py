import json
import shutil
import srt
import uuid


import argparse

parser = argparse.ArgumentParser(description='')
parser.add_argument('--proj', default="")
parser.add_argument('--srt', default="")
parser.add_argument('--out', default="./")

args = parser.parse_args()

def insert_texts(subs, texts):
     for _, sub in enumerate(subs):
            text = {
                "add_type": 1,
                "alignment": 1,
                "background_alpha": 1.0,
                "background_color": "",
                "bold_width": 0.0,
                "border_color": "",
                "border_width": 0.08,
                "check_flag": 7,
                "content": sub.content,
                "font_category_id": "",
                "font_category_name": "",
                "font_id": "",
                "font_name": "",
                "font_path": "/Applications/VideoFusion-macOS.app/Contents/Resources/Font/SystemFont/zh-hans.ttf",
                "font_resource_id": "",
                "font_size": 8.0,
                "font_title": "系统",
                "font_url": "",
                "has_shadow": False,
                "id": str(uuid.uuid4()).upper(),
                "initial_scale": 1.0,
                "italic_degree": 0,
                "ktv_color": "",
                "layer_weight": 1,
                "letter_spacing": 0.0,
                "line_spacing": 0.02,
                "recognize_type": 1,
                "shadow_alpha": 0.8,
                "shadow_angle": -45.0,
                "shadow_color": "#000000",
                "shadow_distance": 8.0,
                "shadow_point": {
                    "x": 1.0182337649086284,
                    "y": -1.0182337649086284
                },
                "shadow_smoothing": 1.0,
                "shape_clip_x": False,
                "shape_clip_y": False,
                "style_name": "",
                "sub_type": 0,
                "text_alpha": 1.0,
                "text_color": "#FFFFFF",
                "text_size": 30,
                "text_to_audio_ids": [
                ],
                "type": "subtitle",
                "typesetting": 0,
                "underline": False,
                "underline_offset": 0.22,
                "underline_width": 0.05,
                "use_effect_default_color": True
            }
            texts.append(text)


def insert_segments(segments, subs, texts, mas):
     for index, sub in enumerate(subs):
            seg = {
                "cartoon": False,
                "clip": {
                    "alpha": 1.0,
                    "flip": {
                        "horizontal": False,
                        "vertical": False
                    },
                    "rotation": 0.0,
                    "scale": {
                        "x": 1.0,
                        "y": 1.0
                    },
                    "transform": {
                        "x": 0.0,
                        "y": -0.56
                    }
                },
                "enable_adjust": False,
                "enable_color_curves": True,
                "enable_color_wheels": True,
                "enable_lut": False,
                "extra_material_refs": [
                    mas[index]["id"]
                ],
                "group_id": "",
                "id": str(uuid.uuid4()).upper(),
                "intensifies_audio": False,
                "is_tone_modify": False,
                "keyframe_refs": [
                ],
                "last_nonzero_volume": 1.0,
                "material_id": texts[index]["id"],
                "render_index": 14000+index,
                "reverse": False,
                "source_timerange": None,
                "speed": 1.0,
                "target_timerange": {
                    "duration": int((sub.end.total_seconds() - sub.start.total_seconds()) * 1000 * 1000),
                    "start": int(sub.start.total_seconds() * 1000 *1000)
                },
                "track_render_index": 0,
                "visible": True,
                "volume": 1.0
            }
            segments.append(seg)

def insert_subtitles(proj_path, srt_path):
    # load srt
    with open(srt_path, 'r') as f:
        text = f.read()
        sg = srt.parse(text)
        subs = list(sg)
    
    
    with open(proj_path, 'r') as f:
        proj = json.loads(f.read())    
        materials = proj['materials']
        materials_animations = []
        
        # insert "material_animations"
        for _ in range(len(subs)):
            animation = {
                "animations": [],
                "id": str(uuid.uuid4()).upper(),
                "type": "sticker_animation",
            }
            materials_animations.append(animation)
        materials["material_animations"] = materials_animations
        
        # insert subtitles
        texts = materials['texts']
        insert_texts(subs, texts)
       
        # insert tracks
        tracks = proj["tracks"]
        index = len(tracks)
        segments = []
        track = {
            "flag": str(index),
            "id" : str(uuid.uuid4()).upper(),
            "type": "text",
            "segments" : segments
        }
        insert_segments(segments, subs, texts, materials_animations)
        tracks.append(track)
        
        with open('draft_info_srt.json', 'w') as f:
            json.dump(proj, f)

    
def main():
    proj = args.proj
    shutil.copyfile(proj, proj[0:-5]+'_bak.json')
    srt  = args.srt
    insert_subtitles(proj, srt)
    



if __name__ == "__main__":
    main()
