extends Label

var character_name = "Person"

var base_text = " is thinking"
var dots = ""
var max_dots = 4
var typing_speed = 1  # Adjust timing for dot animation
var timer: Timer

func _ready():
	timer = Timer.new()
	timer.wait_time = typing_speed
	timer.autostart = false
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)
	
	timer.stop()  # Ensure it's not running

func start_typing_animation():
	if not visible:
		show()
	if not timer.is_stopped():
		return  # Prevent multiple starts
	dots = ""
	text = character_name + base_text
	timer.start()

func stop_typing_animation():
	timer.stop()
	hide()  # Hide the label when stopping
	text = ""  # Clear text

func _on_timer_timeout():
	dots += "."
	if dots.length() > max_dots:
		dots = ""
	text = character_name + base_text + dots
