extends CharacterBody3D

class_name Unit

@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _unhandled_input(event: InputEvent) -> void:
    if DebugTools.test_mode_enabled:
        if event.is_action_pressed("debug_increase"):
            animation_player.play("animation_unit/idle_0")
        elif event.is_action_pressed("debug_decrease"):
            animation_player.play("animation_unit/RESET")
