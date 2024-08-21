extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var animator = $AnimatedSprite2D
	animator.play("idle")

func _physics_process(delta: float) -> void:
	var area = $Area2D

	var bodies = area.get_overlapping_bodies()

	for body in bodies:
		if body is CharacterBody2D:
			var states = body.get_node("States")
			var state = states.current_state

			if state.canKillEnemies:
				print("ok kill this fuck")

func kill(player):
	print("yep, hes dead")
