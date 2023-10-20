## A door to another room
class_name Exit
extends MeshInstance3D

@export var NextLevel: String = "Level2"


## A physics object is overlapping with the exit
func _on_static_body_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		print("Exit was hit")
		Events.ExitHit.emit(self)
