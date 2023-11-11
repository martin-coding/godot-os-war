extends Area2D


@onready var pathFollow: PathFollow2D = get_parent()
@export var speed: float = 40.0

func _physics_process(delta):
	pathFollow.progress += speed * delta
