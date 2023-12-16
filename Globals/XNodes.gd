## Global Nodes Helpers
class_name XNode
extends Node


# Recursively look through the child nodes for a node of a specific type
static func get_child_by_type(node: Node, type_name: String) -> Node:
	for child in node.get_children():
		var childClass = child.get_class()
		if childClass == type_name:
			return child
		else:
			var found_child = XNode.get_child_by_type(child, type_name)
			if found_child:
				return found_child
	return null

# Get the immediate children of a specific type
static func get_children_by_type(node: Node, type_name: String) -> Array[Node] :
	var children_of_type: Array[Node] = []
	for child in node.get_children():
		var child_class = child.get_class()
		print ("Child: " + child_class)
		if child_class == type_name:
			children_of_type.push_back(child)
	return children_of_type
