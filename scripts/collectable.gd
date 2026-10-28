extends Node2D

signal collected


func _ready() -> void:
	await get_tree().create_timer(randf_range(0.1, 0.5)).timeout
	var tween = create_tween()
	tween.tween_property($Visuals/Sprite2D, "position:y", -2.0, 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Visuals/Sprite2D, "scale", Vector2(1.0, 1.0), 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Visuals/Shadow, "scale", Vector2(1.0, 1.0), 0.6).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Visuals/Sprite2D, "position:y", 0.0, 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Visuals/Sprite2D, "scale", Vector2(1.05, 0.95), 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Visuals/Shadow, "scale", Vector2(1.05, 0.95), 0.6).set_trans(Tween.TRANS_SINE)
	tween.set_loops()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		collected.emit()
		$Pickup.play()
		hide()
		$Area2D.set_deferred("monitoring", false)






func _on_pickup_finished() -> void:
	queue_free()
