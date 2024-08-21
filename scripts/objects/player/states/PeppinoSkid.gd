extends PeppinoState
class_name PeppinoSkid

func enter(state):
	animator.play("skid_start")
	player.change_collision("SuperJumpCollision")

func physics_update(delta):
	player.movespeed = move_toward(player.movespeed, 0, 0.4)

	if player.movespeed == 0:
		on_change.emit(self, "PeppinoBase")
		return

	player.velocity.x = (player.movespeed*60)*__getxscale()

func exit(string):
	animator.play("skid_end")
