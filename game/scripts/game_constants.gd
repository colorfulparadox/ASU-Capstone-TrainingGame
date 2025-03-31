extends Node

const json_handling = preload("res://scripts/json_handling.gd")

# load in the quiz game data
@onready var categories = json_handling.load_json("res://quizdata/restaurant_menu_items.json")["entrees"].keys()
@onready var names = json_handling.load_json("res://quizdata/names.json")["names"]
@onready var food_beverage_pairings = json_handling.load_json("res://quizdata/food_beverage_pairings.json")
@onready var quiz_beverage_options_list = json_handling.load_json("res://quizdata/beverage_pairings_options.json")["beverages_list"]
@onready var restaurant_menu_items = json_handling.load_json("res://quizdata/restaurant_menu_items.json")
@onready var gender = names.keys()

const POSSIBLE_CHOICES_COUNT = 3
const MAX_SCORE_PER_QUESTION = 5
const INCORRECT_ANSWER_PENALTY = 2
const GAMESIZE = Vector2(1920, 1440)
const save_path = "user://loginid.save"
const username_save_path = "user://userid.save"

func load_authid():
	if FileAccess.file_exists(save_path):
		print("authid file found")
		var file = FileAccess.open(save_path, FileAccess.READ)
		var authidtext = file.get_var()
		ServerVariables.auth_id = authidtext
		ServerVariables.username = "test"
		print(ServerVariables.auth_id)
		
	if FileAccess.file_exists(username_save_path):
		print("username file found")
		var file = FileAccess.open(username_save_path, FileAccess.READ)
		var usernametext = file.get_var()
		ServerVariables.username = usernametext
		print(ServerVariables.username)
		
	
func save_authid():
	var id_store = FileAccess.open(save_path, FileAccess.WRITE)
	id_store.store_var(ServerVariables.auth_id)
	
	var username_store = FileAccess.open(username_save_path, FileAccess.WRITE)
	username_store.store_var(ServerVariables.username)
