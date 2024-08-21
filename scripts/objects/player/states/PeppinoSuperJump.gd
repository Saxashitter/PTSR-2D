extends PeppinoState
class_name PeppinoSuperJump

@export var isFlipped = false

func enter(state):
	animator.play("superjump")
	player.velocity.x = 0
	player.change_collision("SuperJumpCollision")


func physics_update(delta):
	player.velocity.x = 0
	player.velocity.y = -12*60

	if Input.is_action_just_pressed("grab") or Input.is_action_just_pressed("run"):
		on_change.emit(self, "PeppinoSuperJumpCancel")
		player.velocity.y = 0
		player.movespeed = 12
