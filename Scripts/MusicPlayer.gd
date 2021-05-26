extends Node

var menu_music = load("res://Audio/Menu.wav")
var game_music = load("res://Audio/Game.wav")
var menu_music_play = false
var game_music_play = false

func _ready():
	pass

func play_menu_music():
	$Music.stream = menu_music
	$Music.play()
	menu_music_play = true
	game_music_play = false

func play_game_music():
	$Music.stream = game_music
	$Music.play()
	menu_music_play = false
