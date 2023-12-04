extends Label

func _ready():
	helper.get_game().connect("player_health_update", _on_player_health_update)
	_on_player_health_update()

func _on_player_health_update() -> void:
	text = "❤️" + str(helper.get_game().get_health())
