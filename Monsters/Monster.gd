## A baddie. So evil...
class_name Monster
extends CharacterBody3D

@export var Speed: float = 200.0

@onready var nav: NavigationAgent3D = $NavigationAgent3D
@onready var player_watcher: RayCast3D = $RayCast3D

var age: float = 0
var player: Player
var animationPlayer: AnimationPlayer
var playerVisible: bool = false


## Setup the monster
func _ready() -> void:
	# Find the player to chase
	player = get_tree().get_nodes_in_group("Player")[0] as Player
	print("Monster chasing " + player.name)

	# Notice when the player has exited
	Events.ExitHit.connect(exit_was_hit)

	# Find the animation player
	animationPlayer = XNode.get_child_by_type(self, "AnimationPlayer")


# Play an animation if possible
func PlayAnimation(animName: String, loop):
	if animationPlayer:
		if loop:
			var anim : Animation = animationPlayer.get_animation(animName)
			anim.loop_mode = Animation.LOOP_LINEAR
		animationPlayer.play(animName)


## Update the monster
func _physics_process(delta: float) -> void:
	age += delta
	if age > 1.0 and playerVisible:
		DoNav(delta)

	# Look for the player
	player_watcher.show()
	player_watcher.target_position =  player_watcher.global_position
	playerVisible = player_watcher.is_colliding()
	playerVisible = true
	if playerVisible:
		PlayAnimation("walk", false)
	else:
		PlayAnimation("idle", false)


## Decide where to go
func DoNav(delta: float):
	nav.target_position = player.global_position

	var direction = Vector3()
	var next_position = nav.get_next_path_position()
	direction = next_position - global_position
	direction.y = 0
	direction = direction.normalized()

	velocity = direction * Speed * delta

	# Rotate the monster in the direction of movement
	transform = transform.looking_at(next_position, Vector3.UP, true)
	rotation.x = 0.0
	rotation.z = 0.0

	move_and_slide()


## The player has left the building
func exit_was_hit(_exit: Exit):
	# Stop moving
	Speed = 0.0

