extends Node

signal on_player_take_damage(amount : float)
signal tower_button_pressed(towerClass)

func broadcast_player_take_damage(amount):
	emit_signal("on_player_take_damage", amount)

func broadcast_tower_button_pressed(towerClass):
	emit_signal("tower_button_pressed", towerClass)
