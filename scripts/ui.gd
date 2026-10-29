extends CanvasLayer

func _ready() -> void:
	$ColorRect.show()
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate:a", 0.0, 0.7)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$TimeLabel.text = "%d:%05.2f" % [ int(Run.run_time / 60) , fmod(Run.run_time, 60) ]
