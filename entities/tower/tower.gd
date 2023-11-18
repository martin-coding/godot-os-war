extends Node2D

var bullet = preload("res://entities/tower/bullet.tscn")
var enemies = []
var current_enemy

func _physics_process(_delta):
	if enemies != []:
		current_enemy = enemies[0]
		#look_at(current_enemy.global_position)
		rotation = global_position.angle_to_point(current_enemy.global_position) - 3.1 # the "- 3.1 fixes a weird rotation" | uncomment line above if u want funny tux


func _on_sight_area_area_entered(area):
	if area.is_in_group("enemy"):
		enemies.append(area)
		

func _on_sight_area_area_exited(area):
	if area.is_in_group("enemy"):
		enemies.erase(area)


func _on_shoot_timer_timeout():
	if current_enemy:
		if enemies:
			if current_enemy == enemies[0]:
				var b = bullet.instantiate()
				b.global_position = global_position
				b.target = current_enemy
				get_parent().add_child(b)
