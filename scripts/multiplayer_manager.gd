extends Node

var peer = ENetMultiplayerPeer.new()
var player:PackedScene = preload("res://scenes/objects/player.tscn")

var _players_node

func make_server(port:int):
	var server_peer = ENetMultiplayerPeer.new()
	server_peer.create_server(port)
	server_peer.peer_connected.connect(on_peer_connect)

	multiplayer.set_multiplayer_peer(server_peer)

	on_server_connect()
	add_player_data(1)

	print("Make server.")
func connect_to_server(ip:String, port:int):
	var client_peer = ENetMultiplayerPeer.new()
	client_peer.create_client(ip, port)
	client_peer.peer_connected.connect(on_peer_connect)

	multiplayer.set_multiplayer_peer(client_peer)
	multiplayer.connected_to_server.connect(on_server_connect)

	print("Connect to server.")

# Management

@rpc("any_peer")
func add_player_data(id):
	if !Global.players.has(id):
		Global.players[id] = {
			name = "Peppino",
			id = id,
			score = 0
		}
		print("New user! "+str(id))

	if multiplayer.is_server():
		for i in Global.players:
			print("Send data of "+str(i))
			add_player_data.rpc(i)

func on_peer_connect(id):
	add_player_data.rpc(1, multiplayer.get_unique_id())

func on_server_connect():
	Global.is_multiplayer = true

	add_player_data.rpc_id(1, multiplayer.get_unique_id())
	Global.force_goto_state("menu_wait")
