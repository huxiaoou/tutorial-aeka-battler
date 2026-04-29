extends Node

var test_mode_enabled: bool = false

func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("toggle_test_model"):
        test_mode_enabled = !test_mode_enabled
        if test_mode_enabled:
            print("Test model enabled")
        else:
            print("Test model disabled")
        
