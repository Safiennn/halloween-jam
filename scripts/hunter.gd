extends CharacterBody2D

@export var speed : float = 20.0

# Store route markers in a list
@export var markers : Array[Marker2D]

# Index of the marker the hunter is currently walking to.
var active_marker = 0
var direction = 1
var ghost = null
var is_frozen : bool = false
var is_waiting : bool = false

func _ready() -> void:
	$Sprite2D.material.set_shader_parameter("width", 0)
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
		var target_angle = global_position.direction_to(markers[active_marker].global_position).angle()
		var turn_amount = abs(angle_difference($Flashlight.rotation, target_angle))
		var turn_time = turn_amount / 2.0
		var turn = angle_difference($Flashlight.rotation, target_angle)
		turn_amount = abs(turn)
		var tween = create_tween()
		tween.tween_property($Flashlight, "rotation", $Flashlight.rotation + turn, turn_time)
		if turn_time > 0:
			is_waiting = true
			$WaitTimer.start(turn_time)
		else:
			$Flashlight.show()
			$Flashlight/DetectionRange.monitoring = true
		speed = 20.0
		
	# Make the hunter move towards the active marker.
	else:
		if is_frozen == false and is_waiting == false:
			velocity = global_position.direction_to(markers[active_marker].global_position) * speed
			move_and_slide()
			$Flashlight.rotation = velocity.angle()
			
	if Vector2.from_angle($Flashlight.rotation).x > 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true
		
	if ghost:
		$Flashlight/RayCast2D.target_position = $Flashlight/RayCast2D.to_local(ghost.global_position)
		$Flashlight/RayCast2D.force_raycast_update()
		if not $Flashlight/RayCast2D.is_colliding():
			ghost.get_caught()
	

func get_scared():
	$"!".show()
	speed = 50.0
	direction *= -1
	active_marker += direction
	if global_position.distance_to(markers[active_marker].global_position) < 5:
		active_marker += direction
		active_marker = clamp(active_marker, 0, markers.size() - 1)
		if global_position.distance_to(markers[active_marker].global_position) < 5:
			direction *= -1
			active_marker += direction
	is_frozen = true
	$ScaredTimer.start()
	$Flashlight.hide()
	$Flashlight/DetectionRange.monitoring = false
	show_outline()
	$AudioStreamPlayer2D.play()
	is_waiting = false
	$WaitTimer.stop()

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		ghost = body


func _on_detection_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		ghost = null

func show_outline():
	$Sprite2D.material.set_shader_parameter("width", 1)


func hide_outline():
	$Sprite2D.material.set_shader_parameter("width", 0)


func _on_scared_timer_timeout() -> void:
	is_frozen = false
	$"!".hide()
	


func _on_wait_timer_timeout() -> void:
	is_waiting = false
	$Flashlight.show()
	$Flashlight/DetectionRange.monitoring = true
