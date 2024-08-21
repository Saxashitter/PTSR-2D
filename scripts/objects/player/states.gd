extends Node2D

var states:Dictionary = {};

@export var initial_state:State
@export var player:CharacterBody2D
@export var animator:AnimatedSprite2D

var current_state:State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children(): # the children in state machines basement:
		if child is State:
			states[child.name] = child
			child.player = player
			child.animator = animator
			child.on_change.connect(change_state)

	if initial_state:
		initial_state.enter("Inited")
		current_state = initial_state

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !player.is_multiplayer_authority():
		print("Multiplayer authority is: "+str(player.get_multiplayer_authority()))
		return
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if !player.is_multiplayer_authority(): return
	if current_state:
		current_state.physics_update(delta)

func change_state(state, new_state_name):
	if state != current_state:
		return

	var new_state = states.get(new_state_name)

	if !new_state: return

	if current_state:
		current_state.exit(new_state_name)

	new_state.enter(current_state.name)

	current_state = new_state
