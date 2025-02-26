extends Area2D

const CUSTOMER = preload("res://nodes/customer.tscn")

@onready var button = $tableButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("unoccupied_table")
	button.visible = false
	button.disabled = true
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func temp_leaving():
	$Timer.start(10)

func customer_exit():
	var instance = CUSTOMER.instantiate()
	instance.global_position = global_position
	var customerCollection = get_tree().get_nodes_in_group("customers")[0]
	customerCollection.add_child(instance)
	instance.leaving()
	table_unoccupied()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("customer") && is_in_group("unoccupied_table"):
		table_occupied()
		body.queue_free()
		button.visible = true
		button.modulate.a = 0
		button.disabled = false
	pass # Replace with function body.

func table_occupied():
	remove_from_group("unoccupied_table")
	var new_texture = preload("res://assets/occupied_table.png")
	$Sprite2D.set_texture(new_texture)
	$NavigationObstacle2D.avoidance_layers = 1
	print($NavigationObstacle2D.avoidance_layers)
	temp_leaving()

func table_unoccupied():
	add_to_group("unoccupied_table")
	var new_texture = preload("res://assets/unoccupied_table.png")
	$Sprite2D.set_texture(new_texture)
	$NavigationObstacle2D.avoidance_layers = 2

func _on_timer_timeout() -> void:
	customer_exit()
	pass # Replace with function body.


func _on_table_button_pressed() -> void:
	print("Button was clicked!")
	$Timer.paused = true
	var instance = spawn_order_page(4)
	add_child(instance)
	pass # Replace with function body.

func spawn_order_page(test_value: int) -> Node2D:
	# load packed scene
	# set properties I guess
	var orderpagescene: PackedScene = load("res://nodes/order_page.tscn")
	var instance = orderpagescene.instantiate()
	
	# center it
	instance.position = get_viewport().size * -0.5
	instance.set_z_index(100)
	
	instance.test_property = test_value
	
	return instance
