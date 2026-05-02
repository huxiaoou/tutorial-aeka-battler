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
            anim_player.play("animation_unit/idle_0")
        elif event.is_action_pressed("debug_decrease"):
            anim_player.play("animation_unit/attack_0")
        elif event.is_action_pressed("debug_multi"):
            anim_player.play("animation_unit/attack_1")
    return
