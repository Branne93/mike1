extends Node2D
#export(PackedScene) var next_scene
var mike_original_position= Vector2(0,0)
var mike_new_position = mike_original_position

func _ready():
	mike_original_position = $YSort/mike.position
	$Area2D.connect("body_entered", self, "exit_scene")
	var camera = $YSort/mike.get_node("camera")
	camera.limit_right = 800
	camera.limit_bottom = 600
	
func enter_room():
	var camera = $YSort/mike.get_node("camera")
	camera.limit_right = 800
	camera.limit_bottom = 600

func exit_scene(body):
	if body.name == "mike":
		$YSort/mike.position = mike_original_position
		global.emit_signal("exit", "korridor", $YSort/mike, mike_new_position)
