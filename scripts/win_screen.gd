extends CanvasLayer




func _on_next_button_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
