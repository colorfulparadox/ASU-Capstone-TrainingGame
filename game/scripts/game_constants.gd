extends Node

const json_handling = preload("res://scripts/json_handling.gd")

# load in the quiz game data
@onready var categories = json_handling.load_json("res://assets/restaurant_menu_items.json")["entrees"].keys()
@onready var names = json_handling.load_json("res://assets/names.json")["names"]
@onready var food_beverage_pairings = json_handling.load_json("res://assets/food_beverage_pairings.json")
@onready var quiz_beverage_options_list = json_handling.load_json("res://assets/beverage_pairings_options.json")["beverages_list"]
@onready var restaurant_menu_items = json_handling.load_json("res://assets/restaurant_menu_items.json")

@onready var gender = names.keys()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

const POSSIBLE_CHOICES_COUNT = 3
const MAX_SCORE_PER_QUESTION = 5
const INCORRECT_ANSWER_PENALTY = 2
const GAMESIZE = Vector2(1920, 1440)
