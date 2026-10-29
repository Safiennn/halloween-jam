extends Node2D

@export var music_effect : int = -1
@export var next_level : PackedScene

func _ready() -> void:
	get_tree().paused = false
	Run.is_running = true
	var bus = AudioServer.get_bus_index("Music")
	for i in AudioServer.get_bus_effect_count(bus):
		AudioServer.set_bus_effect_enabled(bus, i, false)
	if music_effect != -1:
		AudioServer.set_bus_effect_enabled(bus, music_effect, true)
