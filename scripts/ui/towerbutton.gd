extends Button

@export var tower_class_reference = preload("res://entities/tower/tower.tscn")
@onready var price_text = get_node("VBoxContainer/HBoxContainer/PriceText")
@onready var tower_image = get_node("VBoxContainer/TowerImage")

var price = -1
var tower_size = Vector2()

func _ready():
	helper.get_game().connect("player_money_update", _on_player_money_update)

	var instance = tower_class_reference.instantiate()
	price = instance.get_price()
	tower_image.texture = instance.get_texture()

	tower_size = instance.scale * 128
	instance.queue_free()
	price_text.text = str(price)

func _on_player_money_update(_money):
	disabled = can_afford() == false
	if disabled:
		modulate = "ff180f"
	else:
		modulate = Color.WHITE

func can_afford():
	return helper.get_game().get_money() >= price

func _on_button_up():
	if can_afford():
		eventmanager.broadcast_tower_button_pressed(self)

func get_tower_texture():
	return tower_image.texture

func get_tower_class():
	return tower_class_reference

func get_cost():
	return price


func _on_mouse_entered():
	eventmanager.broadcast_hover_ui(true)


func _on_mouse_exited():
	eventmanager.broadcast_hover_ui(false)
