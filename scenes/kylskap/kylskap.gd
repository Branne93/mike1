extends Node2D

func _ready():
	pass

func pushpull():
	$Sprite.frame = 1
	$hummus.show()
	$StaticBody2D/CollisionShape2D.disabled = true
