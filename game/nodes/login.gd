extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	


func _on_pressed() -> void:
	var username_input = get_tree().get_nodes_in_group("username")[0]
	var password_input = get_tree().get_nodes_in_group("password")[0]
	var api_node = get_tree().get_nodes_in_group("api_node")[0]
	
	# api_node.ping()
	var success = await api_node.sign_in(username_input.get_line(0), password_input.get_line(0))
	
	if success == true:
		get_tree().change_scene_to_file("res://nodes/restaurant_scene.tscn")
	else:
		$"../Label4".text = "Invalid credentials"
