extends Camera3D

class_name CameraBattle

var move_speed: float = 5.0
var zoom_step: Vector3 = Vector3(0, 0, 0.5)
var zoom_step_count: int = 0

const MAX_ZOOM_STEP_COUNT: int = 5
const MIN_ZOOM_STEP_COUNT: int = -5


func _process(delta: float) -> void:
    var direction: Vector2 = Input.get_vector(
        "camera_move_left",
        "camera_move_right",
        "camera_move_forward",
        "camera_move_backward",
    )
    global_position += Vector3(direction.x, 0, direction.y) * move_speed * delta


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("camera_zoom_in"):
        if zoom_step_count < MAX_ZOOM_STEP_COUNT:
            translate(-zoom_step)
            zoom_step_count += 1
    elif event.is_action_pressed("camera_zoom_out"):
        if zoom_step_count > MIN_ZOOM_STEP_COUNT:
            translate(zoom_step)
            zoom_step_count -= 1
