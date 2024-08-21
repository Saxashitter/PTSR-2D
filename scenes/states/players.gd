extends Node

func _process(delta):
	var player = get_player()

	if player:
		var camera = get_parent().get_node("Camera2D")

		camera.position.x = player.position.x
		camera.position.y = player.position.y

	var c_id = multiplayer.get_unique_id()
func get_player():
	var id = MultiplayerManager.multiplayer.get_unique_id()

	if has_node(str(id)):
		return get_node(str(id))

	if has_node("Player"):
		return get_node("Player")

	return false
