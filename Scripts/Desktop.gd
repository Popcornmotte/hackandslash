extends Node2D

var heavyClick = preload("res://Assets/Sounds/heavyClick.wav")
var time
var jingle = preload("res://Assets/Sounds/loginJingle0.wav")
var wincount = 0 
const zeroPos = Vector2(256,100)

func _ready():
	Audio.playSfx(jingle)
	Input.set_custom_mouse_cursor(load("res://Assets/Sprites/mouse.png"),Input.CURSOR_ARROW)
	pass

func getpos():
	wincount+=1
	$winPos.position=zeroPos+Vector2(wincount*5,wincount*5)
	return $winPos.position

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


func _on_ShutDown_pressed():
	get_tree().quit()
	pass # Replace with function body.
