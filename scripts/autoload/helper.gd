extends Node

func get_game():
	var result = get_tree().get_nodes_in_group("game")
	if result:
		return result[0]
	return null
