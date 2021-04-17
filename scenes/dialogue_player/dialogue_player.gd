extends Node
export(String, FILE, "*.json") var dialogue_file
export var self_talk = false
var mike
var other
var mouse_control

signal dialogue_finished

var dialogue = []
var current = 0
var active = false

func _ready():
	if not self_talk:
		other = get_parent()
	index_dialogue()
	
func _input(event):
	if active and event.is_action_pressed("ui_accept"):
		next_dialogue()
		
func start_dialogue():
	mouse_control = mike.get_node("mouse_control")
	current = 0
	mouse_control.active = false
	active = true
	set_dialogue()
	
	
func set_dialogue():
	if dialogue[current][0] == "mike":
		set_text_mike(dialogue[current][1])
	else:
		set_text_other(dialogue[current][1])
		
func next_dialogue():
	current += 1
	if current >= dialogue.size():
		exit_dialogue()
		return
	set_dialogue()
	
func exit_dialogue():
	mouse_control.active = true
	mouse_control.talk = false
	active = false
	current = 0
	mike.get_node("pratbubbla").hide()
	if not self_talk:
		other.get_node("pratbubbla").hide()
	emit_signal("dialogue_finished")
	
func index_dialogue():
	var dialogue_dict = load_dialogue(dialogue_file)
	for key in dialogue_dict:
		dialogue.append(dialogue_dict[key])

func load_dialogue(file_path):
	var file = File.new()
	if file.file_exists(file_path):
		file.open(file_path, file.READ)
		return parse_json(file.get_as_text())
		
func set_text_other(text):
	mike.get_node("pratbubbla").hide()
	other.get_node("pratbubbla").show()
	other.get_node("pratbubbla").set_text(text)

func set_text_mike(text):
	if not self_talk:
		other.get_node("pratbubbla").hide()
	mike.get_node("pratbubbla").show()
	mike.get_node("pratbubbla").set_text(text)
