extends Node


func _on_button_down():
	var current_scene = get_tree().current_scene
	if current_scene.has_node("kitchen_node"):
		return
	
	var scene = load("res://nodes/kitchen_node.tscn").instantiate()
	get_tree().current_scene.add_child(scene)
	
	
