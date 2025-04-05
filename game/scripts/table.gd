extends Area2D

const CUSTOMER = preload("res://nodes/customer.tscn")

@onready var button = $tableButton

# 0, 1, 2
# table, bar, booth
@export var seat_type: int

var customer_offset: Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("unoccupied_table")
	button.visible = false
	button.disabled = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func temp_leaving():
	$Timer.start(20)

func customer_exit():
	var instance = CUSTOMER.instantiate()
	# start them at sitting position, instead of middle of table
	instance.global_position = global_position
	instance.position += customer_offset 
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
	#$Sprite2D.set_texture(new_texture)
	button.visible = true
	button.modulate.a = 0
	button.disabled = false
	
	spawn_seated_customer()
	
	temp_leaving()

func table_unoccupied():
	add_to_group("unoccupied_table")
	#var new_texture = preload("res://assets/unoccupied_table.png")
	#$Sprite2D.set_texture(new_texture)
	$Sprite2D.texture = null
	destroy_seated_customer()

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
	
func spawn_seated_customer():
	var customersit = CUSTOMER.instantiate()
	add_child(customersit)
	customersit.find_child("Character").pause()
	customersit.set_physics_process(false)
	customersit.set_process(false)
	
	var side = randi() % 2
	var offset: int
	offset = 90 if side == 0 else -85
	
	if seat_type == 0:
		customer_offset = Vector2(offset, -10)
		customersit.position += customer_offset
		if side == 0: customersit.look_left()
		else: customersit.look_right()
	elif seat_type == 1:
		customer_offset = Vector2(0, -25)
		customersit.position += customer_offset
		customersit.look_up()

	elif seat_type == 2:
		customer_offset = Vector2(offset, -10)
		customersit.position += customer_offset
		if side == 0: customersit.look_left()
		else: customersit.look_right()

func destroy_seated_customer():
	$customer.queue_free()
