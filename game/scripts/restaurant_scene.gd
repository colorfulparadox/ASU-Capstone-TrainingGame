extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://nodes/main_menu_ui.tscn")

func _on_show_order_page() -> void:
	
#	This will spawn an order scene that's shown at the top zindex
	var instance = spawn_order_page(4)
	add_child(instance)


func spawn_order_page(test_value: int) -> Node2D:
	# load packed scene

	var orderpagescene: PackedScene = load("res://nodes/order_page.tscn")
	var instance = orderpagescene.instantiate()
	
	# center it, now resistant to fullscreen viewport size wierdness
	instance.position = GameConstants.GAMESIZE * -0.5 
	instance.set_z_index(100)
	
	
	instance.test_property = test_value
	
	return instance
