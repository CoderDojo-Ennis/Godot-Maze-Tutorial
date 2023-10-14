## A baddie. So evil...
class_name Monster
extends CharacterBody3D

@export var Speed: float = 200.0
@onready var nav: NavigationAgent3D = $NavigationAgent3D
var age: float = 0
var player: Player


## Setup the monster
func _ready() -> void:
	# Find the player to chase
	player = get_tree().get_nodes_in_group("Player")[0]
	print("Monster chasing " + player.name)

	# Notice when the player has exited
	Events.ExitHit.connect(exit_was_hit)


## Update the monster
func _physics_process(delta: float) -> void:
	age += delta
	if age > 1.0:
		DoNav(delta)


## Decide where to go
func DoNav(delta: float):
	nav.target_position = player.global_position

	var direction = Vector3()
	direction = nav.get_next_path_position() - global_position
	direction.y = 0
	direction = direction.normalized()

	velocity = direction * Speed * delta

	move_and_slide()


## The player has left the building
func exit_was_hit():
	# Stop moving
	Speed = 0.0
