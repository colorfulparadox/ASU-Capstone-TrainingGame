extends CharacterBody2D

var movement_speed = 165
var rng = RandomNumberGenerator.new()
enum Directions {  
	UP,      
	RIGHT,  
	DOWN,
	LEFT  
}  
var direction = 0
@export var target: Node2D = null

@onready var navigation_agent_2d: NavigationAgent2D = $NavigationAgent2D


# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("seeker_setup")
	add_to_group("customer")
	pass # Replace with function body.
	
	# Not working because when waiting at the door they're already in collision 
	# with the door so it doesn't trigger the body entered flag
func leaving():
	remove_from_group("customer")
	add_to_group("customer_exit")

func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position
		
func acquire_target():
	var available_tables = get_tree().get_nodes_in_group("unoccupied_table")
	if !is_in_group("customer"):
		available_tables = get_tree().get_nodes_in_group("door")
		
	if !available_tables.is_empty():
		var new_target = available_tables[rng.randf_range(1, available_tables.size())-1]
		target = new_target
	else:
		leaving()
		
	navigation_agent_2d.target_position = target.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !is_instance_valid(target) || !(target.is_in_group("unoccupied_table") || target.is_in_group("door")):
		acquire_target()
	if navigation_agent_2d.is_navigation_finished():
		return
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	#print(current_agent_position.direction_to(next_path_position).angle())
	var angle = current_agent_position.direction_to(next_path_position).angle()

	if -(3*PI)/4 < angle and angle < -PI/4:
		direction = 1  # UP
		go_up()

	elif -PI/4 <= angle and angle <= PI/4:
		direction = 2  # RIGHT
		go_right()

	elif PI/4 < angle and angle < (3*PI)/4:
		direction = 3  # DOWN
		go_down()

	elif (3*PI)/4 <= angle or angle <= -(3*PI)/4:
		direction = 4  # LEFT
		go_left()
		
	var new_velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	if !navigation_agent_2d.avoidance_enabled:
		navigation_agent_2d.set_velocity(new_velocity)
	else:
		_on_navigation_agent_2d_velocity_computed(new_velocity)
	
	move_and_slide()
	pass

func occupy_table(body):
	if body == target:
		print("Reached Desired Table")
		body.table_occupied()
		queue_free()

func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	pass # Replace with function body.

func look_left():
	$Character.left()
	$Character.pause()

func look_right():
	$Character.right()
	$Character.pause()

func look_up():
	$Character.up()
	$Character.pause()

func look_down():
	$Character.down()
	$Character.pause()

func go_left():
	$Character.left()

func go_right():
	$Character.right()

func go_up():
	$Character.up()

func go_down():
	$Character.down()
