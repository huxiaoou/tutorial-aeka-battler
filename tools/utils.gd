extends RefCounted

class_name Utils

static func load_json_file(file_path: String) -> Variant:
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

static func get_cfg_animations_lib(animation_lib: String) -> Dictionary:
    var cfg_animations_lib: Dictionary = Utils.load_json_file(animation_lib)
    if cfg_animations_lib is Dictionary:
        return cfg_animations_lib
    print("Error: Failed to load animation library configuration.")
    return { }
