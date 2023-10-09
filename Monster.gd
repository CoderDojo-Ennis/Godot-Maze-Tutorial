extends CharacterBody3D


@export var SPEED = 2.0
const ACCEL = 10.0

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var player: Node3D = $"../Player"

var age: float = 0

func _ready() -> void:
	Events.ExitHit.connect(exit_was_hit)

func _physics_process(delta: float) -> void:
	age += delta
	DoNav(delta)

func DoNav(delta: float):
	if (age < 1.0):
		return
	nav.target_position = player.global_position

	var direction = Vector3()
	direction = nav.get_next_path_position() - global_position
	direction.y = 0
	direction = direction.normalized()

	velocity = direction * SPEED

	move_and_slide()

func exit_was_hit():
	SPEED = 0.0
