extends CanvasLayer

var next_level

func _ready() -> void:
	next_level = $"../..".next_level

func _on_next_button_pressed() -> void:
	Audio.play_click()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)



func _on_next_button_mouse_entered() -> void:
	Audio.play_click()
