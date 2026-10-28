extends CanvasLayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TimeLabel.text = "%d:%05.2f" % [ int(Run.run_time / 60) , fmod(Run.run_time, 60) ]
