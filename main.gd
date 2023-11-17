extends Node2D

var spawners = []

@onready var enemy = preload("res://entities/enemy.tscn")
var projectile = preload("res://entities/projectiles/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawners = get_tree().get_nodes_in_group("spawn_location")
	for spawner in spawners:
		var new_enemy = enemy.instantiate()
		new_enemy.speed = randf_range(40.0, 100.0)
		spawner.add_child(new_enemy)


func _on_timer_timeout():
	spawners = get_tree().get_nodes_in_group("spawn_location")
	for spawner in spawners:
		var new_enemy = enemy.instantiate()
		new_enemy.speed = randf_range(40.0, 100.0)
		spawner.add_child(new_enemy)		


func _on_bullet_shoot():
	var shoot = projectile.instantiate()
	add_child(shoot)
	
