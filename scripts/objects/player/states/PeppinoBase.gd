extends PeppinoState
class_name PeppinoBase

var jumped = false

@export var maxMovespeed = 8*60
@export var maxMovespeed2 = 6*60
@export var accel = 0.5*60
@export var jumpVelocity = -8*60

func physics_update(delta: float):
	if can_mach(): return

	apply_movement(delta)
	do_jump(delta)
	do_animations(delta)

func do_jump(delta: float):
	# Handle jump.
	if not Input.is_action_pressed("jump") and not player.is_on_floor() and jumped:
		jumped = false
		player.velocity.y = 0

	if player.velocity.y >= 0 and not player.is_on_floor() and jumped:
		jumped = false

	if player.is_on_floor() and jumped:
		jumped = false

	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		jumped = true
		player.velocity.y = jumpVelocity

func apply_movement(delta: float):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var dir := Input.get_axis("move_left", "move_right")

	if dir != __getxscale():
		player.movespeed = 2

	if dir != 0:
		if player.movespeed < maxMovespeed:
			player.movespeed += accel
		elif floor(player.movespeed) == maxMovespeed:
			player.movespeed = maxMovespeed2

	player.velocity.x = player.movespeed*dir

func can_mach():
	if Input.is_action_pressed("run") and player.is_on_floor():
		on_change.emit(self, "PeppinoMach")
		return true

func do_animations(delta: float):
	if player.velocity.x < 0 and not animator.flip_h:
		animator.flip_h = true
	elif player.velocity.x > 0 and animator.flip_h:
		animator.flip_h = false

	if animator.animation != idlespr and animator.animation != walkspr and animator.animation != jumpspr: return

	if player.is_on_floor():
		if abs(player.velocity.x) > 0:
			animator.play("walk")

			if player.movespeed < (floor(maxMovespeed2) / 2):
				animator.speed_scale = 0.35
			elif (player.movespeed > (floor(maxMovespeed2) / 2) && player.movespeed < maxMovespeed2):
				animator.speed_scale = 0.45
			else:
				animator.speed_scale = 0.6
		else:
			animator.play('idle')
			animator.speed_scale = 1
	else:
		if animator.animation != "jump_start" and animator.animation != "jump":
			animator.play("jump_start")
			animator.speed_scale = 1
