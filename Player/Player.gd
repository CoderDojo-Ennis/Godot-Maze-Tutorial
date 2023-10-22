## The Hero
class_name Player
extends CharacterBody3D

@export var Health: float = 100.0
@export var FirstPerson: bool = false
@export var JumpVelocity: float = 4.5
@export var Speed: float = 15.0
@export var SpinSpeed: float = 2.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera_1st_person: Camera3D = $Camera1stPerson
@onready var camera_3rd_person: Camera3D = $Camera3rdPerson


func _ready() -> void:
	Events.ExitHit.connect(exit_was_hit)

	# Choose the camera for the input mode
	if FirstPerson:
		camera_1st_person.make_current()
	else:
		camera_3rd_person.make_current()


func _physics_process(delta: float) -> void:
	# Player can't move if they're dead
	if Health <= 0:
		return

	var on_floor = is_on_floor()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if FirstPerson:
		rotate_y(-input_dir.x * SpinSpeed * delta)
		var direction := (transform.basis.z).normalized()
		var vely = velocity.y
		velocity = direction * input_dir.y * Speed
		velocity.y = vely
	else:
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * Speed
			velocity.z = direction.z * Speed
		else:
			velocity.x = move_toward(velocity.x, 0, Speed)
			velocity.z = move_toward(velocity.z, 0, Speed)

	# Add the gravity.
	if not on_floor:
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept"):
		if on_floor:
			velocity.y = JumpVelocity

	move_and_slide()
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)
		if collision.get_collider().is_in_group("Monsters"):
			player_hit_monster()


# Player hit an exit
func exit_was_hit(_exit: Exit):
	# Disable movement
	Speed = 0.0


# Player hit a monster
func player_hit_monster():
	Health = 0.0
	Events.PlayerDied.emit(self)
