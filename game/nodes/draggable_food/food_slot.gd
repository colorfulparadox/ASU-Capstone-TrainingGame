extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return true
	return false
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	data.get_parent().remove_child(data)
	
	# remove offset from anchor so it is centered on the adopting node I guess
	data.position.x = 0
	data.position.y = 0
	
	data.position = (-0.5 * data.size) + (0.25 * data.size)
	
	data.anchor_left = 0.5
	data.anchor_right = 0.5
	data.anchor_top = 0.5
	data.anchor_bottom = 0.5
	var texture_size = data.get_node("TextureRect").texture.get_size()
	data.offset_left = -texture_size.x / 2
	data.offset_right = texture_size.x / 2
	data.offset_top = -texture_size.y / 2
	data.offset_bottom = texture_size.y / 2
	
	# slot inherits the dropped item
	add_child(data)
	
