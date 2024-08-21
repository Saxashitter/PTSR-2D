extends State
class_name PeppinoState

@export var player:CharacterBody2D
@export var animator:AnimatedSprite2D

@export var idlespr:String = "idle"
@export var walkspr:String = "walk"
@export var jumpspr:String = "jump"

@export var canKillEnemies = false
@export var canStrongKillEnemies = false

func __getxscale():
	if not animator.flip_h:
		return 1
	else:
		return -1
