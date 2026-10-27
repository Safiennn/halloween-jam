extends Node2D

var next_level

func _ready() -> void:
	next_level = $"../..".next_level

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_tree().paused = true
		if next_level:
			$"../../CanvasLayers/Win Screen".show()
		else:
			get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")
