extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var heavyClick = preload("res://Assets/Sounds/heavyClick.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	#make mouse invisibly, so sprite mouse hack works (needed so mouse is affected by shader)
	Input.set_custom_mouse_cursor(load("res://Assets/Sprites/empty.png"),Input.CURSOR_ARROW)
	var path = OS.get_system_dir(OS.SYSTEM_DIR_DCIM)
	var arr = path.split("\\",false)
	if arr.size() < 2:
		arr = path.split("/",false)
	for a in arr:
		print(a)
	if arr.size() >= 2:
		global.username = arr[1]
	$NinePatchRect/Username.text = global.username
	$NinePatchRect/Password.grab_focus()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mb"):
		Audio.playSfx(heavyClick)
	if Input.is_action_just_pressed("CRT"):
		if $CRTShader.visible:
			$CRTShader.visible = false
		else:
			$CRTShader.visible = true
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://Scenes/Desktop.tscn")
	pass


func _on_LogInButton_pressed():
	get_tree().change_scene_to_file("res://Scenes/Desktop.tscn")
	pass # Replace with function body.
