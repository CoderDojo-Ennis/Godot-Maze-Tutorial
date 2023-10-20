## Global input helpers
extends Node


func _input(event):
	# Exit the game when ESC is pressed
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
