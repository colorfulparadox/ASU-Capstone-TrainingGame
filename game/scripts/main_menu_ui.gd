extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_title("Project Persona")
	
	GameConstants.load_authid()
	
	if ServerVariables.auth_id != "":
		$LoginLabel.text = ServerVariables.username

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	if ServerVariables.auth_id != "":
		get_tree().change_scene_to_file("res://nodes/restaurant_scene.tscn")
	else:
		get_tree().change_scene_to_file("res://nodes/options_scene.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/options_scene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_login_label_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton && event.pressed):
		if $LoginLabel.text != "":
			print("Clicked, logging out")
			$LoginLabel.text = "Logging out.."
			ServerVariables.auth_id = ""
			ServerVariables.username = ""
			GameConstants.save_authid() # clear it hopefully
			
		get_tree().create_timer(0.5).timeout.connect(
			func () -> void:
				$LoginLabel.text = ""

		)
