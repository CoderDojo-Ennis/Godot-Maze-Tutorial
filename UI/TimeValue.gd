## Time value display
class_name TimeValue
extends RichTextLabel

var time: float = 120.0
var counting_down: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.ExitHit.connect(exit_was_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting_down:
		time = time - delta
		var format_string = "%0.1f"
		text = format_string % time


# Noticed that the player has left. Stop counting down
func exit_was_hit():
	counting_down = false
