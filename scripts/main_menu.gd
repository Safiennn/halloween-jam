extends CanvasLayer





func _on_quit_button_pressed() -> void:
	Audio.play_click()
	get_tree().quit()


func _on_start_button_pressed() -> void:
	Run.run_time = 0.0
	Run.is_running = true
	Audio.play_click()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")


func _on_quit_button_mouse_entered() -> void:
	Audio.play_click()


func _on_start_button_mouse_entered() -> void:
	Audio.play_click()
