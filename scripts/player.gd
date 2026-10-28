extends CharacterBody2D

@export var acceleration : float = 500.0
@export var max_speed : float = 100.0
@export var drift : float = 0.95

var is_possessing : bool = false
var nearby_object = null
var possessed_object = null


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property($Sprite2D, "position:y", -2.0, 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Sprite2D, "scale", Vector2(1.0, 1.0), 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Shadow, "scale", Vector2(1.0, 1.0), 0.6).set_trans(Tween.TRANS_SINE)
	tween.tween_property($Sprite2D, "position:y", 0.0, 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Sprite2D, "scale", Vector2(1.05, 0.95), 0.6).set_trans(Tween.TRANS_SINE)
	tween.parallel().tween_property($Shadow, "scale", Vector2(1.05, 0.95), 0.6).set_trans(Tween.TRANS_SINE)
	tween.set_loops()


func get_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity += input_direction * acceleration * delta
	velocity = velocity.limit_length(max_speed) * drift
	if input_direction.x < 0:
		$Sprite2D.flip_h = true
	elif input_direction.x > 0:
		$Sprite2D.flip_h = false


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if is_possessing:
			_leave_possesion()
		# Only possess if there is a nearby_object.
		elif nearby_object:
			_possession()
			
	# Only move when not possessing anything.
	if not is_possessing:
		get_input(delta)
		move_and_slide()
	
	if Input.is_action_just_pressed("make_noise") and is_possessing:
		if $Timer.is_stopped():
			possessed_object.make_noise()
			$Timer.start()
		else:
			$ScareNotReady.play()

# Hide the player and set velocity to 0 so the player doesn't drift off when leaving.
# Save nearby object into possessed_object variable so leaving still works even if nearby_object changes while inside.
func _possession():
	visible = false
	$PossessSFX.play()
	is_possessing = true
	velocity = Vector2.ZERO
	$CollisionShape2D.disabled = true
	possessed_object = nearby_object
	possessed_object.show_glow()
	

# Show player and set players position to the possessed_object's position.
func _leave_possesion():
	visible = true
	$UnpossessSFX.play()
	is_possessing = false
	$CollisionShape2D.disabled = false
	global_position = possessed_object.global_position
	possessed_object.stop_noise()
	possessed_object.hide_glow()

func set_nearby_object(object):
	nearby_object = object


func clear_nearby_object():
	nearby_object = null

func play_death_sound():
	$AudioStreamPlayer.play()
