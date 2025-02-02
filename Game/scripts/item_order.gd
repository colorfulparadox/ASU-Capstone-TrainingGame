extends Node

signal buttonClicked

var data = null

func _on_button_down():
	buttonClicked.emit()
	print("Button down!")
