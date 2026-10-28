extends CanvasLayer


func _on_quit_button_mouse_entered() -> void:
	Audio.play_click()


func _on_quit_button_pressed() -> void:
	Audio.play_click()
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func _ready() -> void:
	Run.is_running = false
	$FinalTime.text = "Your final time is: " + "%d:%05.2f" % [ int(Run.run_time / 60) , fmod(Run.run_time, 60) ]
