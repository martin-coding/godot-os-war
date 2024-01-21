extends Area2D

var move = Vector2.ZERO
var speed = 500
var look_vec = Vector2.ZERO
var target
var damage = 1
var sprite: Texture2D

func _ready():
	if target != null:
		$Sprite2D.texture = sprite
		#$Sprite2D.look_at(target.global_position)
		$Sprite2D.rotation = global_position.angle_to_point(target.global_position) - 4.5 # Rotate Sprite so the Top of it faces in the direction of the enemy
		look_vec = target.global_position - global_position

func _physics_process(delta):
	move = Vector2.ZERO
	move = move.move_toward(look_vec, delta * speed)
	global_position += move


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func get_damage():
	return damage
