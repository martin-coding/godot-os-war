extends PathFollow2D

@export var speed: float # gets set in main.gd, so we dont really need to initialize any value here

var health = 2

func _ready():
	progress = 0

func _physics_process(delta):
	if progress_ratio < 1.0:
		progress += speed * delta
	else:
		queue_free()
		print("-1 Health")

func _on_area_2d_area_entered(area):
	if area.is_in_group("projectile"):
		health -= 1
		area.queue_free() # destroy the projectile
		if health == 0:
			queue_free() # "kill" the enemy
			print("Enemy died")
