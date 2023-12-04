extends Node2D

var tower_to_place = null
var tower_cost : int = 0

@onready var collision_area = get_node("TextureRect/Area2D")
@onready var ghost_image = get_node("TextureRect")

var offset : Vector2
var b_can_place = false

func _ready():
	eventmanager.connect("tower_button_pressed", _on_tower_button_pressed)

func _on_tower_button_pressed(towerButton):
	tower_to_place = towerButton.get_tower_class()
	ghost_image.texture = towerButton.get_tower_texture()
	tower_cost = towerButton.get_cost()
	offset = Vector2(128, 128) / 2

func _process(delta):
	global_position = get_global_mouse_position() - offset
	if b_can_place:
		modulate = "72c65b"
	else:
		modulate = "f00000"
	visible = is_instance_valid(tower_to_place)

func _physics_process(delta):
	var collisions = collision_area.get_overlapping_areas()
	if collisions:
		b_can_place = false
	else:
		b_can_place = true

func _input(event):
	if b_can_place == false and is_instance_valid(tower_to_place):
		return
	if is_instance_valid(tower_to_place):
		if event.is_action_pressed('left_click'):
			var instance = tower_to_place.instantiate()
			instance.global_position = global_position + offset / 2
			helper.get_tower_group().add_child(instance)
			eventmanager.broadcast_buy_tower(tower_cost)
			tower_to_place = null
			tower_cost = 0