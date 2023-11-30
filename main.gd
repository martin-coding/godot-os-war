extends Node2D

var spawners = []
var health: int = 100

@onready var enemy = preload("res://entities/enemy.tscn")
@onready var healthLbl = get_node("UI Control/Health")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawners = get_tree().get_nodes_in_group("spawn_location")
	
	eventmanager.connect("on_player_take_damage", _on_damage_player)
	
	for spawner in spawners:
		var new_enemy = enemy.instantiate()
		new_enemy.speed = randf_range(60.0, 120.0)
		spawner.add_child(new_enemy)


func _on_timer_timeout():
	spawners = get_tree().get_nodes_in_group("spawn_location")
	for spawner in spawners:
		var new_enemy = enemy.instantiate()
		new_enemy.speed = randf_range(40.0, 120.0)
		spawner.add_child(new_enemy)


func _on_damage_player(value) -> void:
	health -= value
	healthLbl.text = str(health) + "❤️"
