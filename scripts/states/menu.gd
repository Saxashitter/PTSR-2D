extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var button = $CenterContainer/Button
	button.pressed.connect(on_play_press)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_play_press():
	Global.goto_scene("res://scenes/states/menu_play.tscn")
