extends Node3D
class_name MinimapProxy

var Marker: Node3D
var Following: Node3D
@export var CameraFollow: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Following = get_parent_node_3d()
	await XDelay.NextFrame()
	InitProxy()


# Copy the proxy object's global position to the minimap local x/z position
func _process(_delta: float) -> void:
	if Marker:
		Marker.position = Vector3(Following.global_position.x, 0,Following.global_position.z)
		Marker.rotation = Vector3(0, Following.rotation.y, 0)

		if CameraFollow:
			Minimap.MinimapInstance.Follow(Following)

# Find the minimap and set-up
func InitProxy() -> void:
	# var root =get_tree().root
	# var minimap = XNode.get_child_by_type(root, "Minimap")#
	var minimap = Minimap.MinimapInstance
	assert(minimap != null, "Minimap not found")
	assert(get_child_count() == 1, "MinimapProxy requires one child")
	Marker = get_children()[0]
	Marker.reparent(minimap, false)
	print("Create minimap proxy " + Marker.name)
