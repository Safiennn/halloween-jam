extends HSlider


func _on_value_changed(value: float) -> void:
		var bus = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_volume_db(bus, linear_to_db(value))


func _ready() -> void:
		var bus = AudioServer.get_bus_index("Master")
		value = db_to_linear(AudioServer.get_bus_volume_db(bus))
