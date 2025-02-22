extends Node2D

const json_handling = preload("res://scripts/json_handling.gd")

var foods = ["STEAK", "CHICKEN", "FISH"]

@export var test_property: int
@onready var guest_name: String = "Default"
@onready var food_category: String = "Steak"
@onready var total_quiz_score: int = 0
@onready var current_quiz_question: int = 1

@export var total_quiz_questions: int
@export var image_path: String # we want a dynamic meal image based on the category type

@onready var finished = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(test_property)
	
	# quiz logic: determined here or passed in?
	
	total_quiz_questions = 2 # 1 or 2 typically, 40% chance to get a dessert, etc
	
	# update guest prompt message
	$GuestPromptMessage.text = "Guest " + guest_name + " is ordering:"
	
	# update quiz prompt label initially
	$QuizPromptLabel.text = "What beverage does a " + food_category + " entree pair well with..."
	
	# update pairing question progress initially
	update_quiz_progress()
	
	# populate list of their selected menu items
	
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
	
	var test = json_handling.load_json("res://assets/test_json.json")
	print(test)
	
	if finished:
		print("going back to restaurant, submitting order...")
	elif not finished:
		print("you need to finish the quiz before submitting this order")


func _on_send_message_button_pressed() -> void:
	pass # Replace with function body.
