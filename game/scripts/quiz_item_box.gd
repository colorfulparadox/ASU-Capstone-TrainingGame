extends VBoxContainer

var correct_answer: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_question(question_text: String, question_id: int = 0) -> void:
	var q = load("res://nodes/quiz_item.tscn").instantiate()
	q.set_text(question_text)
	
	# connect signal from each quiz item to the quiz item box
	q.get_node("Button").connect("pressed", _on_answer_selected.bind(question_id))
	
	if get_child_count() < GameConstants.POSSIBLE_CHOICES_COUNT:
		add_child(q)
	else:
		print("Cannot add another quiz item! Skipping")

func _on_answer_selected(question_id: int):
	print(question_id, correct_answer)
	
	if question_id == correct_answer:
		print("you chose the correct answer!")
		
		# should we emit a signal...
		# how should we highlight the correct / in correct answer, 
		
		# also do we wait for a confirmation press to move to next quesiton,
		# or just move on to next one after a second?   
	else:
		print("incorrect answer chosen")
	
	pass

func destroy_quizbox():
	queue_free()
