extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var spbutton = $SPButton
	spbutton.pressed.connect(on_play_press)

	var mpbutton = $MPButton
	mpbutton.pressed.connect(on_mult_press)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func on_play_press():
	Global.goto_scene("res://scenes/states/game.tscn")

func on_mult_press():
	Global.goto_scene("res://scenes/states/menu_multiplayer.tscn")
