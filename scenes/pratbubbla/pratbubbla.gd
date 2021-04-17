extends Node2D
export var flipped = false

func _ready():
	$bild.flip_h = flipped
	
func set_text(text):
	$Label.text = text
