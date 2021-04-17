extends Node2D
export(PackedScene) var next_scene
export(Vector2) var mike_new_position

var mike_original_position= Vector2(0,0)
#signal exit(next_scene_packed, mike, mike_new_pos)

func _ready():
	mike_original_position = $mike.position
	$Area2D.connect("body_entered", self, "exit_scene")
	var camera = get_node("mike").get_node("camera")
	$dialogue_player.mike = $mike
	camera.limit_right = 800
	camera.limit_bottom = 600

func exit_scene(body):
	if body.name == "mike":
		$mike.position = mike_original_position
		global.emit_signal("exit", next_scene, $mike, mike_new_position)
