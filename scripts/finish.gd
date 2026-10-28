extends Node2D

var next_level
var collectables
var collectable_amount
var collectables_collected = 0

func _ready() -> void:
	next_level = $"../..".next_level
	collectables = get_tree().get_nodes_in_group("collectable")
	collectable_amount = collectables.size()
	for collectable in collectables:
		collectable.collected.connect(_on_collectable_collected)
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if collectables_collected == collectable_amount:
			get_tree().paused = true
			if next_level:
				$"../../CanvasLayers/Win Screen".show()
			else:
				get_tree().call_deferred("change_scene_to_file", "res://scenes/main_menu.tscn")

func _on_collectable_collected():
	collectables_collected += 1

func _process(delta: float) -> void:
	$"../../CanvasLayers/UI/Label".text = str(collectables_collected) + "/" + str(collectable_amount)
	if collectables_collected == collectable_amount:
		$DoorClosed.hide()
		$DoorOpen.show()
