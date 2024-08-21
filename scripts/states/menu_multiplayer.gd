extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hosting = $Hosting
	var back = $Back

	back.pressed.connect(go_back)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var ip = $IPAddress
	var port = $Port
	var hosting = $Hosting

	ip.editable = !hosting.button_pressed

func go_back():
	Global.goto_scene("res://scenes/states/menu_play.tscn")


func _on_play_pressed() -> void:
	var hosting = $Hosting

	var ip = $IPAddress.text
	var port = int($Port.text)

	if port == 0:
		port = 5029

	print(ip, port)

	if hosting.button_pressed: # ok guys host is hosting
		MultiplayerManager.make_server(port)
	else: # connect to an ip and port
		MultiplayerManager.connect_to_server(ip, port)
