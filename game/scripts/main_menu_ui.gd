extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DisplayServer.window_set_title("Project Persona")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/restaurant_scene.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/options_scene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
