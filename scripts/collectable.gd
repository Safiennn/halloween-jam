extends Node2D

signal collected

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		$Pickup.play()
		hide()
		$Area2D.set_deferred("monitoring", false)






func _on_pickup_finished() -> void:
	queue_free()
