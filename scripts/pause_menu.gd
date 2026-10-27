extends "res://scripts/death_screen.gd"


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		Audio.play_click()
		get_tree().paused = true
		show()
		


func _on_continue_button_pressed() -> void:
	Audio.play_click()
	get_tree().paused = false
	hide()


func _on_quit_button_mouse_entered() -> void:
	Audio.play_click()


func _on_retry_button_mouse_entered() -> void:
	Audio.play_click()


func _on_continue_button_mouse_entered() -> void:
	Audio.play_click()
