extends CanvasLayer

var next_level : PackedScene = preload("res://scenes/level_1.tscn")
var tutorial_level : PackedScene = preload("res://scenes/tutorial.tscn")


func _ready() -> void:
	if OS.has_feature("web"):
		$QuitButton.hide()
	
	if Run.best_time > 0:
		$BestTimeLabel.text = "Record: " + "%d:%05.2f" % [ int(Run.best_time / 60) , fmod(Run.best_time, 60) ]
	else:
		$BestTimeLabel.hide()
	
	var bus = AudioServer.get_bus_index("Music")
	for i in AudioServer.get_bus_effect_count(bus):
		AudioServer.set_bus_effect_enabled(bus, i, false)
	
	$HardcoreCheckBox.button_pressed = Run.hardcore

func _on_quit_button_pressed() -> void:
	Audio.play_click()
	get_tree().quit()


func _on_start_button_pressed() -> void:
	Run.run_time = 0.0
	Run.is_running = true
	Audio.play_click()
	get_tree().change_scene_to_packed(next_level)


func _on_quit_button_mouse_entered() -> void:
	Audio.play_click()


func _on_start_button_mouse_entered() -> void:
	Audio.play_click()


func _on_tutorial_button_mouse_entered() -> void:
	Audio.play_click()


func _on_tutorial_button_pressed() -> void:
	Audio.play_click()
	get_tree().change_scene_to_packed(tutorial_level)


func _on_hardcore_check_box_toggled(toggled_on: bool) -> void:
	Run.hardcore = toggled_on
