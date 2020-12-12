extends Node2D

var heavyClick = preload("res://Assets/Sounds/heavyClick.wav")
var time
var jingle = preload("res://Assets/Sounds/loginJingle0.wav")

func _ready():
	Audio.playSfx(jingle)
	Input.set_custom_mouse_cursor(load("res://Assets/Sprites/mouse.png"),Input.CURSOR_ARROW)
	pass


func _process(delta):
	time = OS.get_datetime()
	$Taskbar/Time/Label.text = str(time.hour).pad_zeros(2)+":"+str(time.minute).pad_zeros(2)
	
	if Input.is_action_just_pressed("mb"):
		Audio.playSfx(heavyClick)
	if Input.is_action_just_pressed("CRT"):
		if $CRTShader.visible:
			$CRTShader.visible = false
		else:
			$CRTShader.visible = true
	pass


func _on_StartButton_pressed():
	if $StartMenu.visible:
		$StartMenu.visible = false
	else:
		$StartMenu.visible = true
	pass # Replace with function body.
