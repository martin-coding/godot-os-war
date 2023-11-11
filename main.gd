extends Node2D

var spawners = []

@onready var enemy = preload("res://entities/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawners = get_tree().get_nodes_in_group("spawn_location")
	# for loop
	spawners[0].add_child(enemy.instantiate())
	spawners[1].add_child(enemy.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
