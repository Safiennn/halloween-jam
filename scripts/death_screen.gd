extends CanvasLayer



func _on_quit_button_pressed() -> void:
	Audio.play_click()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	


func _on_retry_button_pressed() -> void:
	Audio.play_click()
	get_tree().paused = false
	get_tree().reload_current_scene()
	
	


func _on_retry_button_mouse_entered() -> void:
	Audio.play_click()


func _on_quit_button_mouse_entered() -> void:
	Audio.play_click()
