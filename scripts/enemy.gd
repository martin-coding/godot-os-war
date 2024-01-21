extends PathFollow2D

@export var type: int
@onready var sprite_reference = get_node("Sprite2D")
@onready var type2texture = preload("res://art/enemy/enemy-02.png")
@onready var hit_timer = get_node("HitTimer")
@onready var animator = get_node("AnimationPlayer")

var health = 2
var damage = 5
var speed: float

func _ready():
	progress = randf_range(0.0, 40.0) # avoid enemies spawning exactly on top of each other
	speed = randf_range(40.0, 80.0)
	if (type == 2):
		sprite_reference.texture = type2texture
		health = 10
		speed = randf_range(60.0, 120.0)

func _process(_delta):
	sprite_reference.material.set_shader_parameter("progress", get_hit_timer_progress())

func get_hit_timer_progress():
	return hit_timer.time_left / hit_timer.wait_time

func _physics_process(delta):
	if progress_ratio < 1.0:
		progress += speed * delta
	else:
		eventmanager.broadcast_player_take_damage(get_damage())
		eventmanager.broadcast_on_enemy_killed(self) # broadcast enemy got killed
		queue_free()

func get_damage():
	return damage

func _on_area_2d_area_entered(area):
	if area.is_in_group("projectile"):
		hit_timer.start()
		health -= area.get_damage()
		area.queue_free() # destroy the projectile
		if health == 0:
			eventmanager.broadcast_on_enemy_killed(self) # broadcast enemy got killed
			animator.play("Death")

			#queue_free() # "kill" the enemy
