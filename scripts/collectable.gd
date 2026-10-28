extends Node2D

signal collected

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		queue_free()
