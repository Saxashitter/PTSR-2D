extends PeppinoState
class_name PeppinoSuperJumpCancel

func enter(state):
	player.change_collision("NormalCollision")
	player.gravity = false
	animator.play("superjump_cancelstart")

func physics_update(delta):
	player.velocity.y = 0

	var axis = Input.get_axis("move_left", "move_right")

	if axis == 0: axis = __getxscale()

	if axis != __getxscale():
		animator.flip_h = !animator.flip_h

	if animator.animation != "superjump_cancelstart":
		on_change.emit(self, "PeppinoMach")
		player.movespeed = 12
		player.velocity.y = (-4*60)
		animator.play("superjump_cancel")

func exit(state):
	player.gravity = true
