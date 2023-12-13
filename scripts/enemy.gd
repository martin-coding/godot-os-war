extends PathFollow2D

@export var speed: float # gets set in main.gd, so we dont really need to initialize any value here
@onready var sprite_reference = get_node("Sprite2D")
@onready var hit_timer = get_node("HitTimer")

var health = 2
var damage = 5

func _ready():
	progress = randf_range(0.0, 40.0) # avoid enemies spawning exactly on top of each other

func _process(delta):
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
			queue_free() # "kill" the enemy
