extends Button

var tower_class_reference = preload("res://entities/tower/tower.tscn")
@onready var price_text = get_node("VBoxContainer/HBoxContainer/PriceText")
@onready var tower_image = get_node("VBoxContainer/TowerImage")

var price = -1

func _ready():

	var instance = tower_class_reference.instantiate()
	price = instance.get_price()
	tower_image.texture = instance.get_texture()

	instance.queue_free()
	price_text.text = str(price)

func _on_button_up():
	eventmanager.broadcast_tower_button_pressed(self)
