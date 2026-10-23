extends Node2D

@export var show_label : bool = false

# When the player enters the Area, pass the object into the player by calling the set_nearby_object function on the body (player) 
# and passsing the object as a paramater.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_nearby_object(self)
		if show_label:
			$Label.show()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.clear_nearby_object()
		$Label.hide()


func set_color():
	$Sprite2D.modulate = Color(0.0, 0.902, 1.0, 1.0)

func clear_color():
	$Sprite2D.modulate = Color(1.0, 1.0, 1.0, 1.0)

func make_noise():
	var hunters = $NoiseRange.get_overlapping_bodies()
	for hunter in hunters:
		hunter.get_scared()
