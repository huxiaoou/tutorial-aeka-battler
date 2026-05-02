extends Node

const ANIMATION_LIB: String = "res://config/animations_lib.json"


func get_animation_lib(anim_lib_name: String) -> String:
    var cfg_animations_lib: Dictionary = Utils.get_cfg_animations_lib(ANIMATION_LIB)
    return cfg_animations_lib[anim_lib_name]["save_path"]


func get_rpg_maker_animation_lib() -> AnimationLibrary:
    return load(get_animation_lib("rpg_maker"))
