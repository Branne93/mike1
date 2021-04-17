extends Node2D
export(PackedScene) var sovrum
export(PackedScene) var vardagrum
export(Vector2) var mike_new_position

func _ready():
	var camera = get_node("mike").get_node("camera")
	$sovrum_exit.connect("body_entered", self, "exit_sovrum")
	$vardagsrum_exit.connect("body_entered", self, "exit_vardagsrum")
	camera.limit_right = 2631
	camera.limit_bottom = 600
	
func enter_room():
	var camera = get_node("mike").get_node("camera")
	camera.limit_right = 2631
	
	
func exit_sovrum(body):
	if body.name == "mike":
		$mike.position = Vector2(1529.715, 531.906)
		global.emit_signal("exit", sovrum, get_node("mike"), mike_new_position)

func exit_vardagsrum(body):
	if body.name == "mike":
		$mike.position = Vector2(1529.715, 531.906)
		global.emit_signal("exit", vardagrum, get_node("mike"), mike_new_position)
