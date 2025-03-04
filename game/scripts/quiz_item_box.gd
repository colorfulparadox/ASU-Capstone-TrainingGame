extends VBoxContainer

var correct_answer: int
var question_list = []

signal correct_answer_selected
signal incorrect_answer_selected

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	correct_answer_selected.connect(get_parent().get_parent()._on_correct_answer_selected)
	incorrect_answer_selected.connect(get_parent().get_parent()._on_incorrect_answer_selected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_question(question_text: String, question_id: int) -> void:
	var q = load("res://nodes/quiz_item.tscn").instantiate()
	q.set_text(question_text)
	q.set_id(question_id)
	
	if question_id == correct_answer:
		q.set_correct_answer(true)
	
	question_list.append(question_text)
	
	# connect signal from each quiz item to the quiz item box
	q.get_node("Button").connect("pressed", _on_answer_selected.bind(question_id))
	
	if get_child_count() < GameConstants.POSSIBLE_CHOICES_COUNT:
		add_child(q)
	else:
		print("Cannot add another quiz item! Skipping")

func add_secondary_question(question_id: int, correct_answer_text: String, food_category: String) -> void:
	var question_text = pick_other_quiz_item(correct_answer_text, food_category)
	add_question(question_text, question_id)
	question_list.append(question_text)
	
	
func pick_other_quiz_item(correct_answer_text: String, food_category: String) -> String:
	# pick other pairing choices that are not: 
	#	1. the correct answer
	#	2. another correct pairing for that category
	#	3. is not a duplicate of the second option
	
	# if none are found then return an empty string.
	
	for i in range(len(GameConstants.quiz_beverage_options_list)):
		var candidate = GameConstants.quiz_beverage_options_list.pick_random()
		if candidate != correct_answer_text and \
			GameConstants.food_beverage_pairings[food_category].find(candidate) == -1 and \
			question_list.find(candidate) == -1 :
			question_list.append(candidate)
			return candidate
	
	return ""

func _on_answer_selected(question_id: int):
	print(question_id, correct_answer)
	
	if question_id == correct_answer:
		print("you chose the correct answer!")
		correct_answer_selected.emit()

	else:
		print("incorrect answer chosen, subtracting point penalty")
		incorrect_answer_selected.emit()


func destroy_quizbox():
	queue_free()
