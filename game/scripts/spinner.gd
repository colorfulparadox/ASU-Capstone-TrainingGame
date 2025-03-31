extends TextureRect

@export var rotation_speed: float = -4  # Degrees per second

func _ready():
	pivot_offset = size / 2  # Center pivot

func _process(delta):
	rotation += rotation_speed * delta  # Rotate continuously
