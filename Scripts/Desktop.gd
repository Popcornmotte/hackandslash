extends Node2D

var heavyClick = preload("res://Assets/Sounds/heavyClick.wav")

func _ready():
	Input.set_custom_mouse_cursor(load("res://Assets/Sprites/mouse.png"),Input.CURSOR_ARROW)
	pass


func _process(delta):
	if Input.is_action_just_pressed("mb"):
		Audio.playSfx(heavyClick)
	pass
