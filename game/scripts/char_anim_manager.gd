extends Node


@onready
var bodyAnim = $BodyAnim
@onready
var hairAnim = $HairAnim
@onready
var clothingAnim = $ClothingAnim
@onready
var speed_multiplier = 1.1

func _ready():
	up()
	
	hairAnim.speed_scale = speed_multiplier
	bodyAnim.speed_scale = speed_multiplier
	clothingAnim.speed_scale = speed_multiplier

func setAnim(type):
	bodyAnim.play(type)
	hairAnim.play(type)
	clothingAnim.play(type)

func left():
	setAnim('lWalk')

func right():
	setAnim('rWalk')
	
func up():
	setAnim('bWalk')
	
func down():
	setAnim('fWalk')

func pause():
	hairAnim.pause()
	bodyAnim.pause()
	clothingAnim.pause()
