extends "res://scripts/death_screen.gd"


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = true
		show()
