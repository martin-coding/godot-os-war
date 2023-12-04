extends Button

var tower_class_reference = preload("res://entities/tower/tower.tscn")

func _on_button_up():
	eventmanager.broadcast_tower_button_pressed(tower_class_reference)
