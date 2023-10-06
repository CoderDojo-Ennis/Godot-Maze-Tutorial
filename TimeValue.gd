extends RichTextLabel

var time: float = 120.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time = time - delta
	var format_string = "%0.1f"
	text = format_string % time
