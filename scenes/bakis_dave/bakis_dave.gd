extends Node2D

export(String, FILE, "*.json") var dialog_obakis

func _ready():
	$AnimationPlayer.play("bakis_Dave")

func talk(mike):
	$dialogue_player.mike = mike
	$dialogue_player.start_dialogue()

func bli_obakis(mike):
	$Sprite.hide()
	$obakis.show()
	$dialogue_player.mike = mike
	$dialogue_player.dialogue = []
	$dialogue_player.dialogue_file = dialog_obakis
	$dialogue_player.index_dialogue()
	$dialogue_player.start_dialogue()
	yield($dialogue_player, "dialogue_finished")
	global.emit_signal("game_end")
