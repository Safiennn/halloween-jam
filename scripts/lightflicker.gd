extends PointLight2D

var lamp_energy



func _ready() -> void:
	lamp_energy = energy
	flicker()

func flicker():
	var tween = create_tween()
	tween.tween_interval(randi_range(3, 8))
	for i in randi_range(1, 4):
		tween.tween_property(self, "energy", randf_range(0.1, 0.4), randf_range(0.03, 0.08))
		tween.tween_property(self, "energy", lamp_energy, randf_range(0.03, 0.07))
	await tween.finished
	flicker()
