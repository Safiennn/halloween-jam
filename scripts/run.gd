extends Node

var run_time : float = 0.0
var is_running : bool = false




func _process(delta: float) -> void:
	if is_running:
		run_time += delta
