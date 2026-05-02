@tool
extends EditorScript

func _run() -> void:
    main()


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
    var frame_count: int = 3
    var frame_duration: float = 0.2
    var library = AnimationLibrary.new()
    add_animation_to_lib("idle_0", library, frame_count, frame_duration, 0, 0, Animation.LOOP_LINEAR)
    add_animation_to_lib("attack_0", library, frame_count, frame_duration, frame_count, 0, Animation.LOOP_NONE)
    add_animation_to_lib("attack_1", library, frame_count, frame_duration, frame_count, 1, Animation.LOOP_NONE)
    save_my_library(library, Config.RPG_MAKER_ANIMATION_LIB)
    return
