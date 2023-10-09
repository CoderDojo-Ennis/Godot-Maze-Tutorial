extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Events.ExitHit.connect(exit_was_hit)
	visible_ratio = 0.0


func exit_was_hit():
	Tween.new()

	var tween = get_tree().create_tween().bind_node(self).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "visible_characters", text.length(), 2.0)
	tween.tween_callback(self.animation_done)

func animation_done():
	print("Text animation done")
