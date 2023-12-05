extends Node2D

var health: int = 100
var money: int = 100

var b_in_ui = false
@onready var enemy = preload("res://entities/enemy.tscn")
@onready var spawners: Array = get_tree().get_nodes_in_group("spawn_location")

signal player_health_update
signal player_money_update

func set_game_speed(speed):
	Engine.time_scale = speed

func get_game_speed():
	return Engine.time_scale

func _ready():
	eventmanager.connect("on_player_take_damage", _on_damage_player)
	eventmanager.connect("on_buy_tower", _on_buy_tower)
	eventmanager.connect("on_player_hover_ui", on_player_hover_ui)
	eventmanager.connect("on_toggle_game_speed", _on_toggle_game_speed)

	emit_signal("player_money_update", money)
	for spawner in spawners:
		var new_enemy = enemy.instantiate()
		new_enemy.speed = randf_range(60.0, 120.0)
		new_enemy.set_progress(randf_range(0.0, 20.0)) # avoid enemies spawning exactly on top of each other
		spawner.add_child(new_enemy)

func _on_buy_tower(price) -> void:
	money -= price
	emit_signal("player_money_update", money)

func on_player_hover_ui(b_is_in_ui) -> void:
	b_in_ui = b_is_in_ui

func _on_timer_timeout():
	for spawner in spawners:
		var new_enemy = enemy.instantiate()
		new_enemy.speed = randf_range(40.0, 120.0)
		new_enemy.set_progress(randf_range(0.0, 20.0))
		spawner.add_child(new_enemy)

func get_health() -> int:
	return health

func get_money() -> int:
	return money

func is_player_in_ui() -> bool:
	return b_in_ui

func _on_damage_player(value) -> void:
	health -= value
	emit_signal("player_health_update")

func _on_toggle_game_speed(b_sped_up):
	if b_sped_up:
		set_game_speed(3)
	else:
		set_game_speed(1)
