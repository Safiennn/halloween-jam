extends Node2D

@export var show_label : bool = false
@export var sprite_frames : SpriteFrames
@export var sound_fx : AudioStream
@export var noise_light_energy : float
@export var noise_light_color : Color
@export var noise_light_flicker : bool
@export var flicker_min_energy : float = 0.1
@export var flicker_speed : float = 0.1
@export var scare_radius : float = 50.0
@export var progress_bar_height : float = -20.0
var flicker_tween : Tween
var is_possessed : bool = false
var scare_volume
var player

@export var possession_time : float = 5.0
var possession_time_left : float = 5.0


func _ready() -> void:
	$ProgressBar.position.y = progress_bar_height
	$ProgressBar.max_value = possession_time
	possession_time_left = possession_time
	scare_volume = $SoundFX.volume_db
	$NoiseRange/CollisionShape2D.shape.radius = scare_radius
	$AnimatedSprite2D.sprite_frames = sprite_frames
	$SoundFX.stream = sound_fx
	$NoiseLight.energy = noise_light_energy
	$NoiseLight.color = noise_light_color
	$AnimatedSprite2D.play("default")
	$PointLight2D.enabled = false
	$AnimatedSprite2D.material.set_shader_parameter("width", 0)

func _process(delta: float) -> void:
	$ProgressBar.value = possession_time_left
	if is_possessed:
		possession_time_left -= delta
		if possession_time_left <= 0:
			player._leave_possesion()
	elif possession_time_left < possession_time:
		possession_time_left += delta


# When the player enters the Area, pass the object into the player by calling the set_nearby_object function on the body (player) 
# and passsing the object as a paramater.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		show_progress_bar()
		player = body
		body.set_nearby_object(self)
		$AnimatedSprite2D.material.set_shader_parameter("width", 1)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		if not is_possessed:
			hide_progress_bar()
		body.clear_nearby_object()
		$AnimatedSprite2D.material.set_shader_parameter("width", 0)


func make_noise():
	var hunters = $NoiseRange.get_overlapping_bodies()
	for hunter in hunters:
		hunter.get_scared()
	$AnimatedSprite2D.play("scare")
	$NoiseLight.enabled = true
	if flicker_tween:
		flicker_tween.kill()
	if noise_light_flicker:
		flicker_tween = create_tween()
		flicker_tween.tween_property($NoiseLight, "energy", flicker_min_energy, flicker_speed)
		flicker_tween.tween_property($NoiseLight, "energy", noise_light_energy, flicker_speed)
		flicker_tween.set_loops()
	$SoundFX.play()
	$Timer.start()


func stop_noise():
	$AnimatedSprite2D.play("default")
	$NoiseLight.enabled = false
	$NoiseLight.energy = noise_light_energy
	var tween = create_tween()
	tween.tween_property($SoundFX, "volume_db", -40, 0.4)
	await tween.finished
	$SoundFX.stop()
	$SoundFX.volume_db = scare_volume
	if flicker_tween:
		flicker_tween.kill()


func show_glow():
	is_possessed = true
	$PointLight2D.enabled = true
	var hunters = $NoiseRange.get_overlapping_bodies()
	for hunter in hunters:
		hunter.show_outline()


func hide_glow():
	is_possessed = false
	$PointLight2D.enabled = false
	var hunters = $NoiseRange.get_overlapping_bodies()
	for hunter in hunters:
		hunter.hide_outline()


func _on_timer_timeout() -> void:
	stop_noise()


func _on_noise_range_body_entered(body: Node2D) -> void:
	if is_possessed and body.is_in_group("hunter"):
		body.show_outline()


func _on_noise_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("hunter"):
		body.hide_outline()

func show_progress_bar():
	$ProgressBar.show()
	
func hide_progress_bar():
	$ProgressBar.hide()
