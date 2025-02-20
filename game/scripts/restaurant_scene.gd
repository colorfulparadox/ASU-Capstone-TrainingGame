extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/main_menu_ui.tscn")

func _on_show_order_page() -> void:
	
#	This will spawn an order scene that's shown at the top zindex
	var orderpagescene: PackedScene = load("res://nodes/order_page.tscn")
	var instance = orderpagescene.instantiate()
	instance.position = get_viewport().size * -0.5
	instance.set_z_index(100)
	add_child(instance)
