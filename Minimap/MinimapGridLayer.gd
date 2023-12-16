class_name MinimapGridLayer
extends Node3D

@export var Gridmap: GridMap
@export var GridmapTileIndex: int
@export var MinimapMarker: PackedScene
@onready var MeshesContainer: MultiMeshInstance3D = $MultiMeshInstance3D

var minimap: Minimap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("MinimapGridLayer ready")
	minimap = get_parent()
	assert(minimap is Minimap, "Parent must be a minimap")
	XDelay.NextFrame()
	GenerateGridMarkers()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Generate the markers for this gridmap tile type
func GenerateGridMarkers():
	print("Minimap generating gridmap tile index " + str(GridmapTileIndex))
	print("Total tile count = " + str(Gridmap.get_used_cells().size()))

	var count: int = 0
	for x in range(Gridmap.get_used_cells().size()):
		var cell = Gridmap.get_used_cells()[x]
		var cell_item = Gridmap.get_cell_item(cell)
		if cell_item == GridmapTileIndex:
			count += 1

	var Meshes = MultiMesh.new()
	MeshesContainer.multimesh = Meshes
	var markerTemplate = MinimapMarker.instantiate()
	var markerMesh = XNode.get_child_by_type(markerTemplate, "MeshInstance3D")
	Meshes.mesh = (markerMesh as MeshInstance3D).mesh
	Meshes.transform_format = MultiMesh.TRANSFORM_3D
	Meshes.instance_count = count

	count = 0
	for x in range(Gridmap.get_used_cells().size()):
		var cell = Gridmap.get_used_cells()[x]
		var cell_item = Gridmap.get_cell_item(cell)
		if cell_item == GridmapTileIndex:
			count += 1
			#var mapBlock = MinimapMarker.instantiate()
			#minimap.add_child.call_deferred(mapBlock)
			#await XDelay.NextFrame()
			#mapBlock.position = Vector3(cell.x, 0, cell.z)

			var tran = Transform3D(Basis(), Vector3(cell.x, 0, cell.z))
			Meshes.set_instance_transform(count-1, tran)

	print("Matching tile count: " + str(count))
