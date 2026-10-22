extends Node2D


# When the player enters the Area, pass the object into the player by calling the set_nearby_object function on the body (player) 
# and passsing the object as a paramater.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.set_nearby_object(self)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.clear_nearby_object()
