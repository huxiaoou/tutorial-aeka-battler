extends CharacterBody3D

class_name Unit

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_3d: Sprite3D = $Sprite3D


func _ready() -> void:
    print("ready")
    var anim_lib = load(Config.RPG_MAKER_ANIMATION_LIB)
    if anim_lib is AnimationLibrary:
        anim_player.add_animation_library("animation_unit", anim_lib)


func _unhandled_input(event: InputEvent) -> void:
    if DebugTools.test_mode_enabled:
        if event.is_action_pressed("debug_increase"):
            var anim_names: Array[StringName] = anim_player.get_animation_library("animation_unit").get_animation_list()
            if anim_names.size() > 0:
                var anim_name: StringName = anim_names.pick_random()
                anim_player.play("animation_unit/" + anim_name)
                print("Playing animation: ", anim_name)
    return
