extends Node2D

var game = {}
var class_player:PackedScene = preload("res://scenes/objects/player.tscn")

@onready var spawner = $MultiplayerSpawner
signal readyToSpawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.set_game_variables()

	print("ID: "+str(multiplayer.get_unique_id()))

	sync_peers()

@rpc("call_local") func sync_peers():
	var players = multiplayer.get_peers()

	if multiplayer.is_server():
		spawn_multi_player(multiplayer.get_unique_id())
		for player in players:
			spawn_multi_player(player)
			readyToSpawn.emit()
	else:
		await readyToSpawn
		spawn_multi_player(multiplayer.get_unique_id())
		for player in players:
			spawn_multi_player(player)

func spawn_multi_player(id):
	var player = spawn_player_at_point()
	player.name = str(id)

	player.set_multiplayer_authority(id)

	$Players.call_deferred("add_child", player, true)
	print("Added player "+str(id))

func spawn_player_at_point():
	var player = class_player.instantiate()
	var map = $Map/Spawnpoint

	player.position.x = 200
	player.position.y = 200
	player.velocity.x = 0
	player.velocity.y = 0

	$Players.call_deferred("add_child", player, true)

	return player
