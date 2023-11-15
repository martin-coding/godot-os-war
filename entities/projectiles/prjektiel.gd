extends CharacterBody2D

signal shoot


func _on_timer_timeout():
	shoot.emit()

