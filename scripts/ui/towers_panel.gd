extends Panel

func _on_mouse_entered():
	eventmanager.broadcast_hover_ui(true)


func _on_mouse_exited():
	eventmanager.broadcast_hover_ui(false)
