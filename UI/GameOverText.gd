## This is the text that is displayed at the end of a level
class_name GameOverText
extends RichTextLabel

## Hide the text at the start
func _ready() -> void:
	Events.TimeExpired.connect(time_expired)
	Events.PlayerDied.connect(player_died)
	visible_ratio = 0.0


# Game is over because time expired
func time_expired():
	show_game_over()


# Game is over because player died
func player_died(_player: Player):
	show_game_over()


## Show the text when the game is over
func show_game_over():
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "visible_characters", text.length(), 2.0)
	tween.tween_callback(func(): self.animation_done())


## Get notified when the animation has finished
func animation_done():
	pass

