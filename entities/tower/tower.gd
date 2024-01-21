extends Node2D

var bullet = preload("res://entities/tower/bullet.tscn")
var enemies = []
var current_enemy
var ready_to_fire = false
@export var price = 10
@onready var sprite_reference = get_node("Sprite2D")

@onready var shoot_progress_bar = get_node("ShootProgressBar")
@onready var shoot_timer = get_node("ShootTimer")

func _ready():
	shoot_progress_bar.min_value = 0
	shoot_progress_bar.max_value = shoot_timer.wait_time

func _physics_process(_delta):
	if enemies != []:
		current_enemy = enemies[0]
		sprite_reference.rotation = global_position.angle_to_point(current_enemy.global_position) - 3.1 # the "- 3.1 fixes a weird rotation"
		if ready_to_fire == true:
			ready_to_fire = false
			var b = bullet.instantiate()
			b.sprite = sprite_reference.texture
			shoot_timer.start()
			b.global_position = global_position
			b.target = current_enemy
			get_parent().add_child(b)


func _process(_delta):
	shoot_progress_bar.value = shoot_timer.time_left
	if shoot_progress_bar.value == 0:
		shoot_progress_bar.visible = false
	else:
		shoot_progress_bar.visible = true

func _on_sight_area_area_entered(area):
	if area.is_in_group("enemy"):
		enemies.append(area)


func _on_sight_area_area_exited(area):
	if area.is_in_group("enemy"):
		enemies.erase(area)


func _on_shoot_timer_timeout():
	ready_to_fire = true

func get_price() -> int:
	return price

func get_texture() -> Texture2D:
	return $Sprite2D.texture

