extends Control
signal talk
signal pickup
signal pushpull
signal use_item(item)

signal disable_walk
signal enable_walk

func _ready():
	$prata.connect("pressed", self, "talk")
	$ta.connect("pressed", self, "pick_up")
	$puttadra.connect("pressed", self, "pushpull")
	$hummus.connect("pressed", self, "use_hummus")
	$monster.connect("pressed", self, "use_monster")
	$monsterhummus.connect("pressed", self, "use_monsterhummus")
	global.connect("get_hummus", self, "get_hummus")
	global.connect("get_monster", self, "get_monster")
	global.connect("get_monster_hummus", self, "get_monsterhummus")
	
	for child in get_children():
		child.connect("mouse_entered", self, "disable_walk")
		child.connect("mouse_exited", self, "enable_walk")

func talk():
	emit_signal("talk")
func pick_up():
	emit_signal("pickup")
func pushpull():
	emit_signal("pushpull")
	
func use_hummus():
	emit_signal("use_item", "hummus")
	
func use_monster():
	emit_signal("use_item", "monster")
	
func use_monsterhummus():
	emit_signal("use_item", "monsterhummus")
	
func get_hummus():
	$hummus.show()

func get_monster():
	$monster.show()
	
func get_monsterhummus():
	$hummus.hide()
	$monster.hide()
	$monsterhummus.show()

func enable_walk():
	emit_signal("enable_walk")

func disable_walk():
	emit_signal("disable_walk")
