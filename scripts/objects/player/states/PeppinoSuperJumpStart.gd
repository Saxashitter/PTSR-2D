extends PeppinoState
class_name PeppinoSuperJumpStart


func enter(state):
	animator.speed_scale = 1
	animator.play("superjump_start")
	player.change_collision("SuperJumpStartCollision")

func update(delta):
	player.velocity.x = lerp(player.velocity.x, 0.0, 0.25)

	var axis = Input.get_axis("move_left", "move_right")

	if animator.animation != "superjump_start":
		if !Input.is_action_pressed("move_up"):
			on_change.emit(self, "PeppinoSuperJump")
			return

		if axis != 0:
			player.velocity.x = (2*60)*axis

		if axis < 0:
			animator.play("superjump_moveleft")
		elif axis > 0:
			animator.play("superjump_moveright")
		else:
			animator.play("superjump_startlight")

func exit(state):
	player.change_collision("NormalCollision")
