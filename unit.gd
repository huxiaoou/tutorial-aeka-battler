extends CharacterBody3D

class_name Unit

@export var animation_id: Config.AekaLibID

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_3d: Sprite3D = $Sprite3D

var animation_name: String


func _ready() -> void:
    setup_anim()


func setup_anim() -> void:
    animation_name = Config.aeka_id_to_lib_name(animation_id)
    var aeka_lib: AekaLib = Config.get_aeka_lib(animation_name)
    sprite_3d.texture = load(aeka_lib.texture_path) as Texture2D
    sprite_3d.hframes = aeka_lib.hframes
    sprite_3d.vframes = aeka_lib.vframes
    var anim_lib: AnimationLibrary = aeka_lib.get_animation_lib()
    if anim_lib is AnimationLibrary:
        anim_player.add_animation_library(animation_name, anim_lib)


func _unhandled_input(event: InputEvent) -> void:
    if DebugTools.test_mode_enabled:
        if event.is_action_pressed("debug_increase"):
            var anim_lib: AnimationLibrary = anim_player.get_animation_library(animation_name)
            var anim_names: Array[StringName] = anim_lib.get_animation_list()
            if anim_names.size() > 0:
                var anim_name: StringName = anim_names.pick_random()
                anim_player.play("%s/%s" % [animation_name, anim_name])
                print("Playing animation: %s/%s" % [animation_name, anim_name])
    return
