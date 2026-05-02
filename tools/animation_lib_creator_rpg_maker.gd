@tool
extends EditorScript

func load_json_file(file_path: String) -> Variant:
    if FileAccess.file_exists(file_path):
        var data_file = FileAccess.open(file_path, FileAccess.READ)
        var parsed_result = JSON.parse_string(data_file.get_as_text())
        if parsed_result is Dictionary or parsed_result is Array:
            print("JSON content loaded successfully from: ", file_path)
            return parsed_result
        print("Error: Could not parse JSON content.")
    else:
        print("Error: File does not exist.")
    return null


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
    var cfg_animations_lib: Dictionary = load_json_file(Config.ANIMATION_LIB)
    print(cfg_animations_lib)

    for anim_lib_id: String in cfg_animations_lib:
        var anim_lib_data: Dictionary = cfg_animations_lib[anim_lib_id]
        var library = AnimationLibrary.new()
        var frame_duration: float = anim_lib_data["frame_duration"]
        for anim_name: String in anim_lib_data["animations"]:
            var anim_data: Dictionary = anim_lib_data["animations"][anim_name]
            var bgn: int = anim_data["bgn"]
            var stp: int = anim_data["stp"]
            var loop: int = anim_data["loop"]
            var loop_mode: Animation.LoopMode = loop as Animation.LoopMode
            add_animation_to_lib(anim_name, library, frame_duration, bgn, stp, loop_mode)
        print("Animation library created for: ", anim_lib_id)
        save_my_library(library, anim_lib_data["save_path"])
    return
