extends CharacterBody2D

@export var speed : float = 20.0

# Store route markers in a list
@export var markers : Array[Marker2D]

var active_marker = 0
var direction = 1

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
