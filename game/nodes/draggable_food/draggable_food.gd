extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _get_drag_data(at_position: Vector2) -> Variant:
	
	var prev := Control.new()
	var text = TextureRect.new()
	prev.add_child(text)
	text.texture = get_node("TextureRect").texture
	text.scale *= 0.3
	prev.position = (-0.5 * text.size) + (0.25 * text.size) # doesn't work?

	set_drag_preview(prev)
	
	return self
