extends Node

signal go_to(point)
export(NodePath) var actions_path

var talk_cursor = load("res://assets/prata_ikon.png")
var plocka_cursor = load("res://assets/plocka.png")
var putta_cursor = load("res://assets/putta.png")

var monster_cursor = load("res://assets/monster_ultra.png")
var hummus_cursor = load("res://assets/hummus.png")
var monsterhummus_cursor = load("res://assets/monster_hummus.png")

var actions
var walk = true
var talk = false
var pick_up = false
var push_pull = false
var active = true
var monster = false
var hummus = false
var monsterhummus = false

func _ready():
	actions = get_node(actions_path)
	actions.connect("talk", self, "enable_talk")
	actions.connect("pickup", self, "enable_pickup")
	actions.connect("pushpull", self, "enable_pushpull")
	actions.connect("use_item", self, "use_item")
	actions.connect("enable_walk", self, "enable_walk")
	actions.connect("disable_walk", self, "disable_walk")
	#global.emit_signal("get_monster_hummus")

func _input(event):
	if not active:
		return
	var left_click_pressed = event is InputEventMouseButton and event.is_action_pressed("left_click")
	var left_click_release = event is InputEventMouseButton and event.is_action_released("left_click")
	if left_click_pressed:
		$cursor_cast.position = $cursor_cast.get_global_mouse_position()
	if talk and left_click_release:
		talk = false
		talk_to($cursor_cast.get_collider())
		Input.set_custom_mouse_cursor(null)
	elif pick_up and left_click_release:
		pick_up = false
		pick_up($cursor_cast.get_collider())
		Input.set_custom_mouse_cursor(null)
	elif push_pull and left_click_release:
		push_pull = false
		push_pull($cursor_cast.get_collider())
		Input.set_custom_mouse_cursor(null)
	elif monsterhummus and left_click_release:
		monsterhummus = false
		monsterhummus($cursor_cast.get_collider())
		Input.set_custom_mouse_cursor(null)
	elif hummus and left_click_pressed and actions.get_node("monster").is_hovered():
		global.emit_signal("get_monster_hummus")
		hummus = false
		Input.set_custom_mouse_cursor(null)
	elif monster and left_click_pressed and actions.get_node("hummus").is_hovered():
		global.emit_signal("get_monster_hummus")
		monster = false
		Input.set_custom_mouse_cursor(null)
	elif (hummus or monster) and left_click_pressed:
		monster = false
		hummus = false
		Input.set_custom_mouse_cursor(null)
	elif walk and left_click_release:
		emit_signal("go_to", $cursor_cast.get_global_mouse_position())
	
	

func enable_talk():
	talk = true
	Input.set_custom_mouse_cursor(talk_cursor)
	
func enable_pickup():
	pick_up = true
	Input.set_custom_mouse_cursor(plocka_cursor)
func enable_pushpull():
	push_pull = true
	Input.set_custom_mouse_cursor(putta_cursor)

func enable_walk():
	walk = true
	
func disable_walk():
	walk = false

func talk_to(node):
	if node == null:
		return
	node = node.get_parent()
	if node.has_method("talk"):
		node.talk(get_parent())
	talk = false
	
func pick_up(node):
	if node == null:
		return
	node = node.get_parent()
	if node.has_method("pick_up"):
		node.pick_up()
	
func push_pull(node):
	if node == null:
		return
	node = node.get_parent()
	if node.has_method("pushpull"):
		node.pushpull()
		
func monsterhummus(node):
	if node == null:
		return
	node = node.get_parent()
	if node.name == "bakis_dave":
		node.bli_obakis(get_parent())
	
func use_item(item):
	if item == "hummus":
		hummus = true
		Input.set_custom_mouse_cursor(hummus_cursor)
	if item == "monster":
		monster = true
		Input.set_custom_mouse_cursor(monster_cursor)
	if item == "monsterhummus":
		monsterhummus = true
		Input.set_custom_mouse_cursor(monsterhummus_cursor)
