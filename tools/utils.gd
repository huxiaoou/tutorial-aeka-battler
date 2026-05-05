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
    var anim_lib_data: Dictionary = Utils.load_json_file(anim_lib_cfg_path + "/" + anim_lib_name + ".json")
    if anim_lib_data is Dictionary:
        var aeka_lib: AekaLib = AekaLib.new()
        aeka_lib.load_from_dict(anim_lib_data)
        return aeka_lib
    print("Error: Failed to load animation library configuration.")
    return null


static func get_aeka_libs(anim_lib_cfg_path: String) -> Dictionary[String, AekaLib]:
    var dir: DirAccess = DirAccess.open(anim_lib_cfg_path)
    if dir == null:
        print("Error: Could not open directory: ", anim_lib_cfg_path)
        return { }

    var aeka_libs: Dictionary[String, AekaLib] = { }
    dir.list_dir_begin()
    var file_name: String = dir.get_next()
    while file_name != "":
        if file_name.ends_with(".json"):
            var anim_lib_name = file_name.replace(".json", "")
            var aeka_lib: AekaLib = get_aeka_lib(anim_lib_cfg_path, anim_lib_name)
            if aeka_lib != null:
                aeka_libs[anim_lib_name] = aeka_lib
        file_name = dir.get_next()
    return aeka_libs
