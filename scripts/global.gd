extends Node

var game_variables = {}
var current_scene
var deferred_callback

var is_multiplayer = false

var players = {}

func set_game_variables() -> void:
	game_variables = {
		pizzatime = false,
		time = 30,
		overtime = false,
		overtime_time = 120
	}

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func goto_scene(path, callable = null):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:

	call_deferred("_deferred_goto_scene", path, callable)
	
	
func goto_state(path, callable = null):
	call_deferred("_deferred_goto_scene", "res://scenes/states/"+path+".tscn", callable)

func force_goto_scene(path, callable = null):
	_goto_scene(path, callable)

func force_goto_state(path, callable = null):
	_goto_scene("res://scenes/states/"+path+".tscn", callable)

func _goto_scene(path, callable = null):
	get_tree().change_scene_to_file(path)
	if callable: callable.call()

func _deferred_goto_scene(path, callable = null):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene

	if callable:
		callable.call()
