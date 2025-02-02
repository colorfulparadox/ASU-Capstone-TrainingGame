extends Area2D

const CUSTOMER = preload("res://nodes/customer.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start(randi_range(3, 10))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("customer_exit"):
		body.queue_free()
	pass # Replace with function body.

func new_customer_timer():
	$Timer.start(randi_range(3, 10))

func _on_timer_timeout() -> void:
	var instance = CUSTOMER.instantiate()
	instance.global_position = global_position
	var customerCollection = get_tree().get_nodes_in_group("customers")[0]
	customerCollection.add_child(instance)
	new_customer_timer()
	pass # Replace with function body.
