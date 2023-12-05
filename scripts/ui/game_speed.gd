extends Button

@export var regular_speed_image : Texture2D
@export var quick_speed_image : Texture2D

@onready var speed_texture = get_node("TextureRect")

var b_is_Quick = false


func _on_button_up():
	b_is_Quick = !b_is_Quick
	if b_is_Quick:
		speed_texture.texture = quick_speed_image
	else:
		speed_texture.texture = regular_speed_image
	eventmanager.broadcast_toggle_game_speed(b_is_Quick)

func _on_mouse_entered():
	eventmanager.broadcast_hover_ui(true)


func _on_mouse_exited():
	eventmanager.broadcast_hover_ui(false)
