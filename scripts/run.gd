extends Node

const SAVE_PATH = "user://save.cfg"

var run_time : float = 0.0
var is_running : bool = false
var best_time : float = 0.0

func _ready() -> void:
	var save_file = ConfigFile.new()
	if save_file.load(SAVE_PATH) == OK:
		best_time = save_file.get_value("run", "best_time", 0.0)


func _process(delta: float) -> void:
	if is_running:
		run_time += delta

func check_record() -> bool:
	if best_time == 0.0 or run_time < best_time:
		best_time = run_time
		var save_file = ConfigFile.new()
		save_file.set_value("run", "best_time", best_time)
		save_file.save(SAVE_PATH)
		return true
	return false
