extends Node2D


@export var next_level : PackedScene

func _ready() -> void:
	get_tree().paused = false
