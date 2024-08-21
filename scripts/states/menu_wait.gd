extends Control

func _process(delta: float) -> void:
	if !multiplayer.is_server():
		$Button.disabled = true
		$Button.visible = false
	else:
		$Button.disabled = false
		$Button.visible = true

@rpc("any_peer", "call_local")
func _go_to_game():
	Global.force_goto_state("game")

func _on_button_pressed() -> void:
	print("Pressed!")
	_go_to_game.rpc()
