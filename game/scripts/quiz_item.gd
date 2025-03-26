extends Control

@onready var question_id: int = -1
var is_correct_answer: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func set_text(new_text: String) -> void:
	$Button.text = new_text

func set_id(id: int) -> void:
	question_id = id

func set_correct_answer(b: bool) -> void:
	is_correct_answer = b

func _on_button_pressed() -> void:
	if is_correct_answer:
		# highlight yellow
		set_stylebox_color("normal", Color.YELLOW_GREEN)
		# disable button
		$Button.disabled = true
		
	else:
		# highlight red
		set_stylebox_color("normal", Color.DARK_RED)
		# disable button
		$Button.disabled = true
		
		
		

func set_stylebox_color(style_box_type: String, color: Color):
	var stylebox_theme: StyleBoxFlat = get_child(0).get_theme_stylebox(style_box_type).duplicate()
	stylebox_theme.bg_color = color
	stylebox_theme.border_color = color

	get_child(0).add_theme_stylebox_override("normal", stylebox_theme)
	get_child(0).add_theme_stylebox_override("hover", stylebox_theme)
	get_child(0).add_theme_stylebox_override("disabled", stylebox_theme)
