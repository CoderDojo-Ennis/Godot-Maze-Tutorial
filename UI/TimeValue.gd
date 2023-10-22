## Time value display
class_name TimeValue
extends RichTextLabel

var time: float = 120.0
var counting_down: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.ExitHit.connect(exit_was_hit)
	Events.PlayerDied.connect(player_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting_down:
		time = time - delta
		if time <= 0:
			time = 0
			counting_down = false
			Events.TimeExpired.emit()
		var format_string = "%0.1f"
		text = format_string % time


# Noticed that the player has left. Stop counting down
func exit_was_hit(_exit: Exit):
	counting_down = false


# The player died, stop counting down
func player_died(_player: Player):
	counting_down = false
