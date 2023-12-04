extends Node

signal on_player_take_damage(amount : float)
signal tower_button_pressed(towerButton)
signal on_buy_tower(price)
signal on_player_hover_ui(b_is_hovered)

func broadcast_player_take_damage(amount):
	emit_signal("on_player_take_damage", amount)

func broadcast_tower_button_pressed(towerButton):
	emit_signal("tower_button_pressed", towerButton)

func broadcast_buy_tower(price):
	emit_signal("on_buy_tower", price)

func broadcast_hover_ui(b_is_hovered):
	emit_signal("on_player_hover_ui", b_is_hovered)
