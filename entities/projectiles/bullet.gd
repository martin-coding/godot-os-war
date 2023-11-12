extends Area2D

signal shoot
signal hit


func _on_timer_timeout():
	shoot.emit()



func _on_area_entered(area):
	hit.emit()
