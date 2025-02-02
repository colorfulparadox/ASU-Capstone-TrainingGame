extends Node

var itemElement = preload('res://nodes/item_element.tscn')

# placeOrderSignal.emit([{} ... {}])
signal placeOrderSignal(list)

@onready
var orderList = $ColorRect/OrderList/ScrollContainer/VBoxContainer
@onready
var menuList = $ColorRect/Menu/ScrollContainer/VBoxContainer

# {"name": "value", "price": 0, "time": 0}
# time is in seconds 
var items = [
	{"name": "steak", "price": 5.0, "time": 30},
	{"name": "gov cheese", "price": 0.2, "time": 10},
	{"name": "milkshake", "price": 3.0, "time": 10}
]

func _ready():
	for item in items:		
		# update the item to the correct name later
		var itemMenu = itemElement.instantiate()
		#connect button
		itemMenu.buttonClicked.connect(add_item_order)
		#add button to menu
		menuList.add_child(itemMenu)
		
	

func add_item_order():
	print("owo")

func _process(delta):
	pass
