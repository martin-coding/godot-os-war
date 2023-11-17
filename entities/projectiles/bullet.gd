extends Area2D

signal shoot
signal hit


func _on_timer_timeout():
	shoot.emit()
