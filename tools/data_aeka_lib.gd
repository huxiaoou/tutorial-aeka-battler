extends Resource

class_name AekaLib

class AekaAnim extends Resource:
    var bgn: int
    var stp: int
    var loop: Animation.LoopMode


@export var texture_path: String = ""
@export var hframes: int = 0
@export var vframes: int = 0
@export var frame_duration: float = 0.04
@export var animations: Dictionary[String, AekaAnim] = { }
@export var save_path: String = ""


func load_from_dict(d: Dictionary) -> void:
    texture_path = d.get("texture_path", "")
    hframes = d.get("hframes", 0)
    vframes = d.get("vframes", 0)
    frame_duration = d.get("frame_duration", 0.04)
    var anims_dict: Dictionary = d.get("animations", { })
    for anim_name in anims_dict.keys():
        var anim_data: Dictionary = anims_dict[anim_name]
        var anim: AekaAnim = AekaAnim.new()
        anim.bgn = anim_data.get("bgn", 0)
        anim.stp = anim_data.get("stp", 0)
        anim.loop = anim_data.get("loop", 0) as Animation.LoopMode
        animations[anim_name] = anim
    save_path = d.get("save_path", "")
    return


func get_animation_lib() -> AnimationLibrary:
    var library: AnimationLibrary = load(save_path) as AnimationLibrary
    if library is AnimationLibrary:
        return library
    return null
