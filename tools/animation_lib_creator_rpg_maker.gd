@tool
extends EditorScript

func _run() -> void:
    main()


func add_animation_to_lib(
        anim_name: String,
        lib: AnimationLibrary,
        frame_duration: float,
        bgn: int,
        stp: int,
        loop_mode: Animation.LoopMode,
) -> void:
    var anim: Animation = Animation.new()
    anim.length = (stp - bgn) * frame_duration
    anim.loop_mode = loop_mode
    anim.step = frame_duration
    anim.add_track(Animation.TYPE_VALUE)
    anim.track_set_path(0, "Sprite3D:frame")
    for i: int in range(bgn, stp):
        anim.track_insert_key(0, frame_duration * (i - bgn), i)
    lib.add_animation(anim_name, anim)
    return


func save_my_library(library: AnimationLibrary, path: String):
    # Ensure the directory exists
    # Use "res://my_animations.tres" as a typical path
    var error = ResourceSaver.save(library, path)
    if error == OK:
        print("Library saved successfully to: ", path)
    else:
        print("An error occurred while saving: ", error)
    return


func main() -> void:
    var frame_duration: float = 0.2
    var library = AnimationLibrary.new()

    add_animation_to_lib("idle_0", library, frame_duration, 0, 3, Animation.LOOP_LINEAR)
    add_animation_to_lib("idle_1", library, frame_duration, 9, 12, Animation.LOOP_LINEAR)
    add_animation_to_lib("idle_2", library, frame_duration, 18, 21, Animation.LOOP_LINEAR)
    add_animation_to_lib("idle_3", library, frame_duration, 27, 30, Animation.LOOP_LINEAR)
    add_animation_to_lib("idle_4", library, frame_duration, 36, 39, Animation.LOOP_LINEAR)
    add_animation_to_lib("idle_5", library, frame_duration, 45, 48, Animation.LOOP_LINEAR)

    add_animation_to_lib("attack_0", library, frame_duration, 3, 6, Animation.LOOP_NONE)
    add_animation_to_lib("attack_1", library, frame_duration, 12, 15, Animation.LOOP_NONE)
    add_animation_to_lib("attack_2", library, frame_duration, 21, 24, Animation.LOOP_NONE)
    add_animation_to_lib("attack_3", library, frame_duration, 30, 33, Animation.LOOP_NONE)
    add_animation_to_lib("attack_4", library, frame_duration, 39, 42, Animation.LOOP_NONE)
    add_animation_to_lib("attack_5", library, frame_duration, 48, 51, Animation.LOOP_NONE)

    save_my_library(library, Config.RPG_MAKER_ANIMATION_LIB)
    return
