extends Node2D

var health: int = 100
var money: int = 100
var difficulty: int = 5
var wave: int = 0
var enemyList: Array

var b_in_ui = false
@onready var enemy = preload("res://entities/enemy.tscn")
@onready var spawners: Array = get_tree().get_nodes_in_group("spawn_location")

signal player_health_update
signal player_money_update
signal wave_update

func set_game_speed(speed):
	Engine.time_scale = speed

func get_game_speed():
	return Engine.time_scale

func _ready():
	eventmanager.connect("on_player_take_damage", _on_damage_player)
	eventmanager.connect("on_buy_tower", _on_buy_tower)
	eventmanager.connect("on_player_hover_ui", on_player_hover_ui)
	eventmanager.connect("on_toggle_game_speed", _on_toggle_game_speed)
	eventmanager.connect("on_enemy_killed", onEnemyKilled)

	emit_signal("player_money_update", money)

func _on_buy_tower(price) -> void:
	money -= price
	emit_signal("player_money_update", money)

func on_player_hover_ui(b_is_in_ui) -> void:
	b_in_ui = b_is_in_ui

func _on_timer_timeout():
	# TODO: Different Enemy Types | ex. Instead of Spawning 5 Enemies, spawn a more difficult one -- kind of done, need to implement more enemies
	# TODO: (may be fixed with the todo above): When large amounts of enemies need to be spawned, the spawning lags the game
	if enemyList == []:
		wave += 1
		emit_signal("wave_update", wave)
		var localDiff = difficulty
		while localDiff > 0:
			var spawner = spawners[randi_range(0, spawners.size()-1)]
			var new_enemy = enemy.instantiate()
			if (localDiff >= 10):
				new_enemy.type = 2
				localDiff -= 5
			else:
				localDiff -= 1
			spawner.add_child(new_enemy)
			enemyList.append(new_enemy)

		difficulty = difficulty + ceil(wave * 1.2)
		print("Difficulty: " + str(difficulty))

func get_health() -> int:
	return health

func get_money() -> int:
	return money

func is_player_in_ui() -> bool:
	return b_in_ui

func _on_damage_player(value) -> void:
	health -= value
	emit_signal("player_health_update")

func onEnemyKilled(enemy) -> void:
	enemyList.erase(enemy)
	money += 1
	emit_signal("player_money_update", money)
	# TODO: Dont add money when the enemy gets destroyed due to finishing the path

func _on_toggle_game_speed(b_sped_up):
	if b_sped_up:
		set_game_speed(3)
	else:
		set_game_speed(1)
