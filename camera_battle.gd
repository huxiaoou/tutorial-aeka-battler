extends Camera3D

class_name CameraBattle

var move_speed: float = 5.0


func _process(delta: float) -> void:
    var direction: Vector2 = Input.get_vector(
        "camera_move_left",
        "camera_move_right",
        "camera_move_forward",
        "camera_move_backward",
    )
    global_position += Vector3(direction.x, 0, direction.y) * move_speed * delta
