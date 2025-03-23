extends Node


@onready
var bodyAnim = $BodyAnim
@onready
var hairAnim = $HairAnim
@onready
var clothingAnim = $ClothingAnim


func setAnim(type):
	bodyAnim.play(type)
	hairAnim.play(type)
	clothingAnim.play(type)
