extends CanvasLayer

var level_time = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	level_time += delta
	$TimeLabel.text = "%d:%05.2f" % [ int(level_time / 60) , fmod(level_time, 60) ]
