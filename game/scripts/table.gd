extends Area2D

const CUSTOMER = preload("res://nodes/customer.tscn")

@onready var button = $tableButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("unoccupied_table")
	button.visible = false
	button.disabled = true



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
	print("Table Contact")
	if body.is_in_group("customer") && is_in_group("unoccupied_table"):
		body.occupy_table(self)

func table_occupied():
	remove_from_group("unoccupied_table")
	var new_texture = preload("res://assets/occupied_table.png")
	$Sprite2D.set_texture(new_texture)
	button.visible = true
	button.modulate.a = 0
	button.disabled = false
	temp_leaving()

func table_unoccupied():
	add_to_group("unoccupied_table")
	#var new_texture = preload("res://assets/unoccupied_table.png")
	#$Sprite2D.set_texture(new_texture)
	$Sprite2D.texture = null

func _on_timer_timeout() -> void:
	customer_exit()


func _on_table_button_pressed() -> void:
	$Timer.paused = true
	
	# This will break if the restaurant -> tables -> table structure changes
	var instance = get_node("/root/RestaurantScene").spawn_order_page(4)
	print(instance)
	instance.timerImport = $Timer
	instance.buttonImport = $tableButton
	get_parent().get_parent().add_child(instance)
	
	
