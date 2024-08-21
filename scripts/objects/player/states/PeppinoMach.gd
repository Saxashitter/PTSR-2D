extends PeppinoState
class_name PeppinoMach
# handles machs 1, 2, 3, and 4

var machs = [
	[6, 0.075, 8],
	[8, 0.1, 12],
	[12, 0.025, 16],
	[16, 0.1, 20]
]
# layout: [0] = initial speed, [1] = acceleration

func get_current_mach():
	for i in machs.size():
		var mach = machs[i]

		if i == machs.size()-1:
			return [i+1, false]

		var nextMach = machs[i+1]

		if player.movespeed < nextMach[0]:
			return [i+1, true]

		continue

func enter(state):
	player.movespeed = machs[0][0]
	animator.speed_scale = 1

func physics_update(delta):
	var curMach = get_current_mach()
	var machData = machs[curMach[0]-1]

	if !Input.is_action_pressed("run") and player.is_on_floor():
		on_change.emit(self, "PeppinoSkid")
		return

	if player.movespeed < machData[2]: player.movespeed += machData[1]

	var state = str("mach", curMach[0])

	if player.is_on_floor():
		animator.play(state)

	if curMach[0] == 1:
		var dir = Input.get_axis("move_left", "move_right")

		if dir == 0: dir = __getxscale()

		if dir != __getxscale():
			animator.flip_h = !animator.flip_h
		

	player.velocity.x = (player.movespeed*60)*__getxscale()


	if curMach[0] >= 3:
		if Input.is_action_pressed("move_up") and player.is_on_floor():
			on_change.emit(self, "PeppinoSuperJumpStart")
