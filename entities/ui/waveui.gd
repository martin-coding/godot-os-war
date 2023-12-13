extends Label

func _ready():
	helper.get_game().connect("wave_update", _on_wave_update)

func _on_wave_update(amount) -> void:
	text = "Wave: " + str(amount)
