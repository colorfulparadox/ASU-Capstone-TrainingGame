extends Node

signal buttonClicked

var data = null

func _button_pressed():
	buttonClicked.emit()
	print("button press!")


func _on_button_button_down():
	buttonClicked.emit()
	print("Button down!")
