extends Area2D

var move = Vector2.ZERO
var speed = 500
var look_vec = Vector2.ZERO
var target
var damage = 1

func _ready():
	if target != null:
		$Sprite2D.look_at(target.global_position)
		look_vec = target.global_position - global_position

func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta * speed)
	#move = move.normalized() * speed
	global_position += move


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func get_damage():
	return damage
