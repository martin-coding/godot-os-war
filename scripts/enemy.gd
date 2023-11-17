extends PathFollow2D

@export var speed: float = 0.0 # gets set in main.gd, so we dont really need to initialize any value here

var health = 1

func _ready():
	progress = 0

func _physics_process(delta):
	if progress_ratio < 1.0:
		progress += speed * delta
	else:
		queue_free()
		print("-1 Health")

# to take lifepoints
func _on_area_2d_body_entered(body):
	health -= 1
	body.queue_free() # destroy the projectile
	if health == 0:
		queue_free()
		print("Enemy died")

