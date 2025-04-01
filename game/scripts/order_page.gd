extends Node2D

# values to be initialized when order page is spawned
@onready var guest_name: String = "Default"
@onready var food_category: String = "Default"
@export var total_quiz_questions: int

@export var test_property: int

@onready var total_quiz_score: int = 0
@onready var current_quiz_question: int = 1
@onready var finished = false
var maximum_score: int = GameConstants.MAX_SCORE_PER_QUESTION
var conversation_started:bool = false
var conversation_id: String

var use_typewriter = true

# dessert chance
var rng = RandomNumberGenerator.new()
var add_dessert: bool = rng.randf() < 0.4

# decide on the entree name of their chosen category
var entree_choice = ""
var dessert_choice = ""

var timerImport: Timer
var buttonImport: Button

var correct_wine_entree: String
var correct_dessert_wine: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_corner_radius()
	
	$ChatHistoryTextArea.scroll_following = true
	
	guest_name = GameConstants.names[GameConstants.gender.pick_random()].pick_random()
	conversation_id = guest_name + Time.get_datetime_string_from_system()
	print("conversation id %s" % conversation_id)
	
	if timerImport:
		print("Received Timer:", timerImport)
	else:
		print("No Timer")
	
	if buttonImport:
		print("Received Button:", buttonImport)
	else:
		print("No Timer")
	
	$NextButton.disabled = true
	$SubmitButton.disabled = true
	
	$StatusMessage.character_name = guest_name
	
	# category selection
	food_category = GameConstants.categories.pick_random()
	
	entree_choice = GameConstants.restaurant_menu_items["entrees"][food_category].pick_random()
	dessert_choice = GameConstants.restaurant_menu_items["desserts"].pick_random()
	
	print("order page information:")
	print("- adding dessert? " + str(add_dessert))
	print("- food category? " + food_category)
	print("- customer's name?: " + guest_name)
	
	# disable the persona interaction if playing guest mode
	if ServerVariables.auth_id == "":
		$SendMessageButton.disabled = true
		$MessageEntry.editable = false
	
	# 1 or 2 typically, 40% chance to get a dessert, etc
	if add_dessert:
		total_quiz_questions = 2
	else:
		total_quiz_questions = 1
	
	# update guest prompt message
	$GuestPromptMessage.text = "Guest " + guest_name + " is ordering:"
	
	# update quiz prompt label initially
	$QuizPromptLabel.text = "What wine or beverage does a " + food_category + " entree pair well with..."
	
	# assign quiz questions
	spawn_questions()
	
	# update pairing question progress initially
	update_quiz_progress()
	
	# populate list of their selected menu items
	var fooditemlabel = load("res://nodes/food_item_label.tscn").instantiate()
	fooditemlabel.text = "- " + entree_choice
	$FoodVBox.add_child(fooditemlabel)
	
	if add_dessert:
		var dessertlabel = load("res://nodes/food_item_label.tscn").instantiate()
		dessertlabel.text = "- " + dessert_choice
		$FoodVBox.add_child(dessertlabel)
	
	# update initial score to 0
	update_score(0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_score(add: int) -> void:
	total_quiz_score += add
	$ScoreLabel.text = "Score: " + str(total_quiz_score)

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
	
	if test == "" or test == " ":
		return
	
	# add a point per message sent
	update_score(1)
	
	if conversation_started == false:
		$ChatHistoryTextArea.text = ""
	
	$ChatHistoryTextArea.text += "[b]Server[/b]: %s\n" % test


	if conversation_started == false:
		# start api conversation
		conversation_started = true
		# formatted string with dynamic details
		var instruction = generate_instruction()

		show_spinner()
		$StatusMessage.start_typing_animation()
	
		var response = await $API_Node.start_conversation(ServerVariables.auth_id, test, instruction, conversation_id)
		var response_text = response[1]
		var formattedresponse = "[b]%s[/b]: %s\n" % [guest_name, response_text]
		
		# correct some text artifacts
		formattedresponse = formattedresponse.replace("â", "'") 
		
		if use_typewriter:
			typewriter($ChatHistoryTextArea, formattedresponse, true)
		else:
			$ChatHistoryTextArea.text += formattedresponse
		
		$StatusMessage.stop_typing_animation()
		
		
		
	else:
		show_spinner()
		$StatusMessage.start_typing_animation()
		var response = await $API_Node.continue_conversation(ServerVariables.auth_id, test, conversation_id)
		var response_text = response
		var formattedresponse = "[b]%s[/b]: %s\n" % [guest_name, response_text]
		if use_typewriter:
			typewriter($ChatHistoryTextArea, formattedresponse, true)
		else:
			$ChatHistoryTextArea.text += formattedresponse
		
		$StatusMessage.stop_typing_animation()
		
	
	await get_tree().process_frame
	
	hide_spinner()
	
func _on_submit_order() -> void: 
	if finished:
		print("going back to restaurant, submitting order...")
		
		# destroy this order page instance
		# Commented out timer function is for just a normal 
		# unpause vs an instant leave
		#timerImport.paused = false
		if timerImport != null:
			timerImport.emit_signal("timeout")
		if buttonImport != null:
			buttonImport.disabled = true
		
		ServerVariables.session_score += total_quiz_score
		
		if conversation_started:
			# close conversation with API
			show_spinner()
			var out = await $API_Node.end_conversation(ServerVariables.auth_id)
			print("out status: ", out)
			if out == true:
				print('conversation closed succesfully')
			hide_spinner()
		queue_free()
	elif not finished:
		print("you need to finish the quiz before submitting this order")

# when signal is received that correct answer was selected
func _on_correct_answer_selected() -> void:
	print("order page received correct answer signal!")

	# increment score
	update_score(maximum_score)
	
	reset_max_score()
	
	$NextButton.disabled = false

	if current_quiz_question == total_quiz_questions:
		finished = true

func _on_incorrect_answer_selected() -> void:
	print("order page received incorrect answer signal!")
	
	apply_max_score_penalty()

func reset_max_score() -> void:
	maximum_score = GameConstants.MAX_SCORE_PER_QUESTION

func apply_max_score_penalty() -> void:
	maximum_score -= GameConstants.INCORRECT_ANSWER_PENALTY


func spawn_questions() -> void:
	var t = load("res://nodes/quiz_item_box.tscn")
	var tinstance = t.instantiate()
	
	# quiz items: pick one correct answer, then pick randomly twice from the beverage list
	var correct_answer = range(1, GameConstants.POSSIBLE_CHOICES_COUNT + 1).pick_random()

	tinstance.correct_answer = correct_answer
	var correct_answer_text = GameConstants.food_beverage_pairings[food_category].pick_random()
	
	print("\nspawning questions")
	print(food_category)
	
	if food_category == "dessert":
		correct_dessert_wine = correct_answer_text
	else:
		correct_wine_entree = correct_answer_text
	
	for i in range(1, GameConstants.POSSIBLE_CHOICES_COUNT + 1):
		if i == correct_answer:
			tinstance.add_question(correct_answer_text, i)
		else:
			tinstance.add_secondary_question(i, correct_answer_text, food_category)
	
	$QuizItemBoxHolder.add_child(tinstance)

func set_corner_radius() -> void:
	# hacky sorta way to set corner radius on all buttons or whatever with a given theme
	const radius = 15
	$SubmitButton.get_theme_stylebox("normal").set_corner_radius_all(radius)
	$SubmitButton.get_theme_stylebox("hover").set_corner_radius_all(radius)
	$SubmitButton.get_theme_stylebox("pressed").set_corner_radius_all(radius)
	#$ChatHistoryTextArea.get_theme_stylebox("normal").set_corner_radius_all(radius)
	$MessageEntry.get_theme_stylebox("normal").set_corner_radius_all(radius)
	$NextButton.get_theme_stylebox("normal").set_corner_radius_all(radius)
	$NextButton.get_theme_stylebox("hover").set_corner_radius_all(radius)
	$NextButton.get_theme_stylebox("pressed").set_corner_radius_all(radius)
	$NextButton.get_theme_stylebox("disabled").set_corner_radius_all(radius)

func _on_next_button_pressed() -> void:
	
	if finished:
		print("finished. let's go to the exit card")
		# we should go to a third "quiz complete" page
		spawn_exit_card()
		
		$SubmitButton.disabled = false
		
		return
	
	if add_dessert:
		# destroy current quiz box
		$QuizItemBoxHolder.get_child(0).queue_free()
		
		# increment question counter
		current_quiz_question += 1
		update_quiz_progress()

		$QuizPromptLabel.text = "What wine or beverage does a dessert pair well with..."
		food_category = "dessert"

		# spawn new quiz box
		spawn_questions()

func spawn_exit_card():
	var t = load("res://nodes/quiz_item_box.tscn")
	var tinstance = t.instantiate()
	
	var message = load("res://nodes/exit_card_label.tscn").instantiate()
	message.text = "Finished! Time to submit this order and move on to the next customer"
	tinstance.add_child(message)
	
	$QuizItemBoxHolder.get_child(0).queue_free()
	$QuizItemBoxHolder.add_child(tinstance)
	
	$NextButton.disabled = true

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		# close all conversations
		var out = await $API_Node.end_conversation(ServerVariables.auth_id)
		print("out status: ", out)
		if out == true:
			print('conversation closed succesfully')
		get_tree().quit() # default behavior

func show_spinner():
	$Spinner.show()
	$Spinner.set_process(true)
	
func hide_spinner():
	$Spinner.hide()
	$Spinner.set_process(false)

func generate_instruction() -> String:
	var instruction = """
	You are a restaurant guest dining at Bourbon Steak at Fairmont Scottsdale Princess. 
	Your name is %s. You are ordering an %s entree. 
	Specifically, the %s meal.
	You are a friendly and engaging guest, interacting with the user, who is your restaurant server. 
	Greet them warmly, ask any relevant questions about the menu, and place your order in a natural, 
	conversational manner. Be polite, appreciative, and, if appropriate, express enthusiasm about the meal.
	You are not necessarily looking for meal recommendations.
	You are sometimes interested in possible wine or beverage pairings with your chosen entree category.”
	""" % [guest_name, entree_choice, food_category]
	# food & beverage pairing knowledge
	instruction += "The ideal wine or beverage pairings for your entree category are: "
	for ideal_pairing in GameConstants.food_beverage_pairings[food_category]:
		instruction += ","
	instruction += ". The given correct answer for this situation is %s. If this one is mentioned you are to agree with it warmly." % correct_wine_entree
	instruction += "The server is being trained to suggest to you the correct wine, beer or beverage\
	pairing with your meal. If they get it wrong based on the provided pairings act like you'll trust them\
	but that you think another option might be better."
	
	# dessert section
	if add_dessert:
		instruction += " You are also ordering a dessert, specifically, the %s" % dessert_choice
		
		instruction += "The ideal wine or beverage pairings for your dessert are:"
		for ideal_pairing in GameConstants.food_beverage_pairings["dessert"]:
			instruction += ","
		instruction += ". The given correct answer for this dessert pairing situation is %s. If this one is mentioned you are to agree with it warmly." % correct_wine_entree
		instruction += "Focus primarily on the entree pairing and your interest about the entree and dessert"
	else:
		instruction += " You do not plan on ordering a dessert."

	
	return instruction
	

func typewriter(textInput: RichTextLabel, message: String, percharacter=false):
	var words = message.split(" ")
	
	for word in words:
		if percharacter:
			for char in word:
				textInput.text += char
				await get_tree().create_timer(0.008).timeout  # Adjust speed as needed
			textInput.text += " "
			await get_tree().create_timer(0.05).timeout  # Pause before next word
		else:
			textInput.text += word + " "
			await get_tree().create_timer(0.05).timeout  # Adjust speed for words
