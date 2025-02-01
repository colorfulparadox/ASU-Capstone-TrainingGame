extends Node

var itemElement: PackedScene = load('res://nodes/item_element.tscn')

# {"name": "value", "price": 0, "time": 0}
# time is in seconds 
var items = [
	{"name": "steak", "price": 5.0, "time": 30},
	{"name": "gov cheese", "price": 0.2, "time": 10},
	{"name": "milkshake", "price": 3.0, "time": 10}
]

func _ready():
	for item in items:
		print(item)
	


func _process(delta):
	pass
