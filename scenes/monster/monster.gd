extends Node2D

func _ready():
	pass

func pick_up():
	global.emit_signal("get_monster")
	hide()
