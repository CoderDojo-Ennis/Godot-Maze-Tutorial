## This is the text that is displayed at the end of a level
class_name LevelCompleteText
extends RichTextLabel

## Hide the text at the start
func _ready() -> void:
	Events.ExitHit.connect(exit_was_hit)
	visible_ratio = 0.0


## Show the text when an exit is found
func exit_was_hit(exit: Exit):
	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "visible_characters", text.length(), 2.0)
	tween.tween_callback(func(): self.animation_done(exit))


## Get notified when the animation has finished
func animation_done(exit: Exit):
	print("Exiting to " + str(exit.NextLevel))

	var levelFileName = "res://Levels/" + exit.NextLevel+ ".tscn"
	#var nextLevel = load(levelFileName)
	#get_tree().change_scene_to_packed() change_scene_with_transition(TRANSITION_TYPE_FADE, 1.0, nextLevel)
	get_tree().change_scene_to_file(levelFileName)

