## Global Nodes Helpers
class_name XNode
extends Node


# Recursively look through the child nodes for a node of a specific type
static func get_child_by_type(node: Node, type_name: String):
	for child in node.get_children():
		if child.get_class() == type_name:
			return child
		else:
			var found_child = XNode.get_child_by_type(child, type_name)
			if found_child:
				return found_child
	return null
