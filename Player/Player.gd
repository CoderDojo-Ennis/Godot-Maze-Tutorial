## The Hero
class_name Player
extends CharacterBody3D

@export var Health: float = 100.0
@export var FirstPerson: bool = false
@export var JumpVelocity: float = 4.5
@export var Speed: float = 12.0
@export var SpinSpeed: float = 2.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_sensitivity: float = 0.002
var pitch: float = 0
var yaw: float = 0
var rotation_default: Vector3


@onready var camera_1st_person: Camera3D = $Camera1stPerson
@onready var camera_3rd_person: Camera3D = $Camera3rdPerson



func _ready() -> void:
	rotation_default = rotation_degrees
	Events.ExitHit.connect(exit_was_hit)
	set_view_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func set_view_mode():
	# Choose the camera for the input mode
	if FirstPerson:
		camera_1st_person.make_current()

		# Level the camera when switching to 1st person
		rotation.x = rotation_default.x
	else:
		camera_3rd_person.make_current()


func _input(event: InputEvent) -> void:
	# C button changes the camera view
	if (event.is_action_pressed("Camera Change")):
		FirstPerson = !FirstPerson
		set_view_mode()

	# ESC key to exit the game
	elif (event.is_action_pressed("Exit")):
		get_tree().quit()

	elif event is InputEventMouseMotion:
		yaw -= event.relative.x * mouse_sensitivity
		pitch -= event.relative.y * mouse_sensitivity
		pitch = clamp(pitch, 0, PI/2)
		rotation_degrees.x = rad_to_deg(pitch)
		rotation_degrees.y = rad_to_deg(yaw)


func _physics_process(delta: float) -> void:
	# Player can't move if they're dead
	if Health <= 0:
		return

	var on_floor = is_on_floor()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

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
	if Input.is_action_just_pressed("Jump"):
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
