extends PathFollow2D

@export var speed: float = 40.0

var health = 1

func _ready():
	progress = 0

func _physics_process(delta):
	if progress_ratio < 1.0:
		progress += speed * delta
	else:
		queue_free()
		print("-1 Health") # gets called multiple times

# to take lifepoints
func _on_bulet_hit():
	health -= 1
	if health == 0:
		queue_free()
		print("deat")
