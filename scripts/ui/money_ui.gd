extends HBoxContainer

@onready var money_text = get_node("MoneyText")
func _ready():
	helper.get_game().connect("player_money_update", _on_player_money_update)

func _on_player_money_update(amount) -> void:
	money_text.text = str(amount)
