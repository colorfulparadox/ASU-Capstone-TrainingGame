extends Node2D

# values to be initialized when order page is spawned
@onready var guest_name: String = "Default"
@onready var food_category: String = "Default"
@export var total_quiz_questions: int
@export var image_index: int # we want a dynamic meal image based on the category type

@export var test_property: int

@onready var total_quiz_score: int = 0
@onready var current_quiz_question: int = 1
@onready var finished = true #false

# dessert chance
var rng = RandomNumberGenerator.new()
var add_dessert: bool = rng.randf() < 0.4


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# category selection
	food_category = GameConstants.categories.pick_random()
	
	print("order page information:")
	print("- adding dessert? " + str(add_dessert))
	print("- food category? " + food_category)
	print("- customer's name?: " + guest_name)
	
	
	# 1 or 2 typically, 40% chance to get a dessert, etc
	if add_dessert:
		total_quiz_questions = 2
	else:
		total_quiz_questions = 1
	
	# update guest prompt message
	$GuestPromptMessage.text = "Guest " + guest_name + " is ordering:"
	
	# update quiz prompt label initially
	$QuizPromptLabel.text = "What beverage does a " + food_category + " entree pair well with..."
	
	spawn_questions()
	
	# update pairing question progress initially
	update_quiz_progress()

	# decide on the entree name of their chosen category
	var entree_choice = GameConstants.restaurant_menu_items["entrees"][food_category].pick_random()
	
	# populate list of their selected menu items
	var fooditemlabel = load("res://nodes/food_item_label.tscn").instantiate()
	fooditemlabel.text = "- " + entree_choice
	$FoodVBox.add_child(fooditemlabel)
	
	if add_dessert:
		var dessertlabel = load("res://nodes/food_item_label.tscn").instantiate()
		dessertlabel.text = "- Dessert"
		$FoodVBox.add_child(dessertlabel)
	
	# assign quiz items
	
	# update initial score to 0
	$ScoreLabel.text = "Score: " + str(total_quiz_score)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_quiz_progress() -> void:
	$QuizProgressLabel.text = "Food & Beverage Pairing Question " + \
								str(current_quiz_question) + " / " + \
								str(total_quiz_questions)

func _on_press_enter(new_text: String) -> void:
	print('enter!')
	_on_send_message()

func _on_send_message() -> void:
	print()
	print("sending message")
	var test = $MessageEntry.text
	print(test)
	print()
	
	$MessageEntry.clear()

func _on_submit_order() -> void: 
	if finished:
		print("going back to restaurant, submitting order...")
		
		# destroy this order page instance
		queue_free()
	elif not finished:
		print("you need to finish the quiz before submitting this order")

func spawn_questions() -> void:
	var t = load("res://nodes/quiz_item_box.tscn")
	var tinstance = t.instantiate()
	# quiz items: pick one correct answer, then pick randomly twice from the beverage list
	
	var correct_answer = 1 # 1, 2, 3, etc
	tinstance.correct_answer = 1
	
	print("\nspawning questions")
	print(food_category)
	
	for i in range(1, GameConstants.POSSIBLE_CHOICES_COUNT + 1):
		tinstance.add_question("question " + str(i), i)
	
	$QuizItemBoxHolder.add_child(tinstance)
