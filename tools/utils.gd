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


static func get_aeka_lib(anim_lib_cfg_path: String, anim_lib_name: String) -> AekaLib:
    var cfg_animations_lib: Dictionary = Utils.load_json_file(anim_lib_cfg_path)
    if cfg_animations_lib is Dictionary:
        var aeka_lib: AekaLib = AekaLib.new()
        aeka_lib.load_from_dict(cfg_animations_lib[anim_lib_name])
        return aeka_lib
    print("Error: Failed to load animation library configuration.")
    return null


static func get_aeka_libs(anim_lib_cfg_path: String) -> Array[AekaLib]:
    var cfg_animations_lib: Dictionary = Utils.load_json_file(anim_lib_cfg_path)
    if cfg_animations_lib is Dictionary:
        var aeka_libs: Array[AekaLib] = []
        for anim_lib_name in cfg_animations_lib.keys():
            var aeka_lib: AekaLib = AekaLib.new()
            aeka_lib.load_from_dict(cfg_animations_lib[anim_lib_name])
            aeka_libs.append(aeka_lib)
        return aeka_libs
    print("Error: Failed to load animation library configuration.")
    return []
