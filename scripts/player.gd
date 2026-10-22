extends CharacterBody2D

@export var acceleration : float = 500.0
@export var max_speed : float = 100.0
@export var drift : float = 0.95

var is_possessing : bool = false
var nearby_object = null
var possessed_object = null

func get_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity += input_direction * acceleration * delta
	velocity = velocity.limit_length(max_speed) * drift


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

# Hide the player and set velocity to 0 so the player doesn't drift off when leaving.
# Save nearby object into possessed_object variable so leaving still works even if nearby_object changes while inside.
func _possession():
	visible = false
	is_possessing = true
	velocity = Vector2.ZERO
	possessed_object = nearby_object

# Show player and set players position to the possessed_object's position.
func _leave_possesion():
	visible = true
	is_possessing = false
	global_position = possessed_object.global_position

func set_nearby_object(object):
	nearby_object = object


func clear_nearby_object():
	nearby_object = null
