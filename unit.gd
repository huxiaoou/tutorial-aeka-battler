extends CharacterBody3D

class_name Unit

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_3d: Sprite3D = $Sprite3D


func _ready() -> void:
    add_rpg_maker_style_animation()
    print("ready")


func _unhandled_input(event: InputEvent) -> void:
    if DebugTools.test_mode_enabled:
        if event.is_action_pressed("debug_increase"):
            anim_player.play("animation_unit/idle_0")
        elif event.is_action_pressed("debug_decrease"):
            anim_player.play("animation_unit/attack_0")
        elif event.is_action_pressed("debug_multi"):
            anim_player.play("animation_unit/attack_1")
    return


func add_animation_to_lib(
        anim_name: String,
        lib: AnimationLibrary,
        frame_count: int,
        frame_duration: float,
        x_bgn: int,
        y: int,
        loop_mode: Animation.LoopMode,
) -> void:
    var anim: Animation = Animation.new()
    anim.length = frame_count * frame_duration
    anim.loop_mode = loop_mode
    anim.step = frame_duration
    anim.add_track(Animation.TYPE_VALUE)
    anim.track_set_path(0, "Sprite3D:frame_coords")
    for i: int in range(frame_count):
        anim.track_insert_key(0, frame_duration * i, Vector2i(x_bgn + i, y))
    lib.add_animation(anim_name, anim)
    return


func add_rpg_maker_style_animation() -> void:
    var library = AnimationLibrary.new()
    anim_player.add_animation_library("animation_unit", library)
    var frame_count: int = 3
    var frame_duration: float = 0.2
    add_animation_to_lib("idle_0", library, frame_count, frame_duration, 0, 0, Animation.LOOP_LINEAR)
    add_animation_to_lib("attack_0", library, frame_count, frame_duration, frame_count, 0, Animation.LOOP_NONE)
    add_animation_to_lib("attack_1", library, frame_count, frame_duration, frame_count, 1, Animation.LOOP_NONE)
    return
