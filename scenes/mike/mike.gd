extends KinematicBody2D

export(NodePath) var pathfinder_path
export var speed = 80

var pathfinder

var path = null
var path_index = 0

func _ready():
	pathfinder = get_node(pathfinder_path)
	$mouse_control.connect('go_to', self, 'find_path')
	$AnimationPlayer.play("mike_sta")
	
func _physics_process(delta):
	if not path:
		return
	var target = path[path_index]
	if position.distance_to(target) < 1:
		path_index = wrapi(path_index + 1, 0, path.size())
		target = path[path_index]
	var direction = (target - position).normalized()
	$Sprite.flip_h = direction.x < 0
	move_and_slide(direction * speed)
	if position.distance_to(path[-1]) < 25: 
		path = null
		set_animation("mike_sta")

func find_path(point):
	path_index = 0
	path = pathfinder.get_simple_path(position, point)
	set_animation("mike_ga")
	
func set_animation(name):
	$AnimationPlayer.play(name)
