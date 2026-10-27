extends CharacterBody2D

@export var speed : float = 20.0

# Store route markers in a list
@export var markers : Array[Marker2D]

# Index of the marker the hunter is currently walking to.
var active_marker = 0
var direction = 1
var ghost = null

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, "rotation_degrees", -3.0, 0.1).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Sprite2D, "scale", Vector2(1.0, 1.0), 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Shadow, "scale", Vector2(1.0, 1.0), 0.6).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "rotation_degrees", 3.0, 0.1).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Sprite2D, "scale", Vector2(1.05, 0.95), 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Shadow, "scale", Vector2(1.05, 0.95), 0.6).set_trans(Tween.TRANS_SINE)
	tween.set_loops()


func _physics_process(_delta: float) -> void:
	if global_position.distance_to(markers[active_marker].global_position) < 5:
		# When the last marker is reached, make the hunter go backwards.
		if active_marker == markers.size() - 1:
			direction = -1
		# Once the hunter has reached the first marker, make the hunter go forwards.
		if active_marker == 0:
			direction = +1
		# Move the hunter to the next marker.
		active_marker += direction
		
	
	# Make the hunter move towards the active marker.
	else:
		velocity = global_position.direction_to(markers[active_marker].global_position) * speed
		move_and_slide()
		if velocity.x > 0:
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
		$Flashlight.rotation = velocity.angle()
		
	if ghost:
		$Flashlight/RayCast2D.target_position = $Flashlight/RayCast2D.to_local(ghost.global_position)
		$Flashlight/RayCast2D.force_raycast_update()
		if not $Flashlight/RayCast2D.is_colliding():
			ghost.play_death_sound()
			get_tree().paused = true
			$"../../CanvasLayers/Death Screen".show()

func get_scared():
	direction *= -1
	active_marker += direction


func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		ghost = body


func _on_detection_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		ghost = null
