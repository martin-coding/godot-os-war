extends Node

signal on_player_take_damage(amount : float)

func broadcast_player_take_damage(amount):
	emit_signal("on_player_take_damage", amount)
