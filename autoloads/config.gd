extends Node

const AEKA_LIB_CFG_PATH: String = "res://config/aekalib/"

enum AekaLibID {
    FLYING_HARE,
    TEST,
}


func aeka_id_to_lib_name(id: AekaLibID) -> String:
    match id:
        AekaLibID.FLYING_HARE:
            return "flyinghare"
    return ""


func get_aeka_lib(anim_lib_name: String) -> AekaLib:
    return Utils.get_aeka_lib(AEKA_LIB_CFG_PATH, anim_lib_name)
