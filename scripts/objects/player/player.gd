extends CharacterBody2D

var jumped = false

@export var movespeed = 0
@export var currentCollision:CollisionShape2D
@export var gravity = true

@export var multiName = "Peppino"

@export var character = "P"

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _ready():
	var animator = $AnimatedSprite2D

	animator.connect("animation_finished", animation_finishmanager)
	animator.play("idle")

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	apply_gravity(delta)
	move_and_slide()

func change_collision(colName):
	currentCollision.disabled = true

	currentCollision = get_node(colName)
	currentCollision.disabled = false

func apply_gravity(delta: float):
	if !gravity: return

	# Add the gravity.
	if not is_on_floor():
		var gravity = get_gravity()*60
		velocity.x += gravity.x

		if velocity.y < 0:
			velocity.y += gravity.y/2
		else:
			velocity.y += gravity.y

func move_camera():
	var camera = $Camera2D
	camera.offset.x = velocity.x/16

# hmm yes animation

func animation_finishmanager():
	var anim_transitions = {}
	var animator = $AnimatedSprite2D

	anim_transitions["skid_end"] = "idle"
	anim_transitions["jump_start"] = "jump"
	anim_transitions["skid_start"] = "skid"
	anim_transitions["skid_end"] = "idle"
	anim_transitions["superjump_start"] = "superjump_startlight"
	anim_transitions["superjump_end"] = "idle"
	anim_transitions["superjump_cancelstart"] = "superjump_cancel"

	if anim_transitions.has(animator.animation):
		animator.play(anim_transitions[animator.animation])
