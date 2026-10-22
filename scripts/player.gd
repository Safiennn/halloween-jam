extends CharacterBody2D

@export var acceleration : float = 500.0
@export var max_speed : float = 100.0
@export var drift : float = 0.95

func get_input(delta):
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity += input_direction * acceleration * delta
	velocity = velocity.limit_length(max_speed) * drift



func _physics_process(delta: float) -> void:
	get_input(delta)
	move_and_slide()
