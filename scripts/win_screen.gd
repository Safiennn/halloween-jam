extends CanvasLayer




func _on_next_button_pressed() -> void:
	Audio.play_click()
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_next_button_mouse_entered() -> void:
	Audio.play_click()
