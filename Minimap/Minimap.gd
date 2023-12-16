class_name Minimap
extends Node3D

@onready var minimap_camera: Camera3D = $SubViewportContainer/SubViewport/MinimapCamera
static var MinimapInstance: Minimap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MinimapInstance = self
	print ("Minimap ready")
	await XDelay.NextFrame()
	GenerateMinimap()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func GenerateMinimap() -> void:
	print ("Minimap Generate")
	#var minimap_grid_layers = XNodes.get_children_by_type(self, "MinimapGridLayer")
	#for mgl in minimap_grid_layers:
	#	(mgl as MinimapGridLayer).GenerateGridMarkers()

func PositionCamera() -> void:
	minimap_camera.position.x = position.x
	minimap_camera.position.z = position.z

func Follow(player: Node3D):
	minimap_camera.position.x = position.x + player.global_position.x
	minimap_camera.position.z = position.y + player.global_position.z
