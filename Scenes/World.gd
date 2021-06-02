extends Node2D

var dialogbox_scene = preload("res://Mini Scenes/Dialog Box.tscn")
var dialogbox
var dialogbox_num = 0

func _process(_delta):
	if dialogbox_num == 1:
		$Player.MAX_SPEED = 0
	else:
		$Player.MAX_SPEED = 500
	if Input.is_action_pressed("ui_cancel"):
		if dialogbox_num == 1:
			$CanvasLayer.get_child(0).hide()
		$Player/FadeIn.show()
		$Player/FadeIn.fade_in()

func _ready():
	MusicPlayer.play_game_music()
	dialogbox_num += 1
	dialogbox = dialogbox_scene.instance()
	dialogbox.dialogpath = "res://Text/Intro.json"
	$CanvasLayer.add_child(dialogbox)

func _on_Player_Gold():
	if dialogbox_num != 1:
		dialogbox_num += 1
		dialogbox = dialogbox_scene.instance()
		dialogbox.dialogpath = "res://Text/Gold.json"
		$CanvasLayer.add_child(dialogbox)

func _on_Player_Rock():
	if dialogbox_num != 1:
		dialogbox_num += 1
		dialogbox = dialogbox_scene.instance()
		dialogbox.dialogpath = "res://Text/Rock.json"
		$CanvasLayer.add_child(dialogbox)

func _on_FadeIn_fade_finished():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Menu/Main Menu.tscn")

func _on_Area2D_body_entered(_body):
	if dialogbox_num != 1:
		dialogbox_num += 1
		dialogbox = dialogbox_scene.instance()
		dialogbox.dialogpath = "res://Text/End.json"
		$CanvasLayer.add_child(dialogbox)
