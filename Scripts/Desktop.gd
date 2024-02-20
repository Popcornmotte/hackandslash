extends Control


var heavyClick = preload("res://Assets/Sounds/heavyClick.wav")
var time
var jingle = preload("res://Assets/Sounds/loginJingle0.wav")
var wincount = 0 
const WINDOW = preload("res://Assets/ObjectScenes/window.tscn")
const zeroPos = Vector2(256,100)

func _ready():
	global.desktop = self
	$CRTShader.show()
	Audio.playSfx(jingle)
	Input.set_custom_mouse_cursor(load("res://Assets/Sprites/mouse.png"),Input.CURSOR_ARROW)
	pass

func getpos():
	wincount+=1
	$winPos.position=zeroPos+Vector2(wincount*5,wincount*5)
	return $winPos.position

func _process(delta):
	$Label.text = "HP: "+str(global.hp)
	time = Time.get_datetime_dict_from_system()
	$Taskbar/Time/Label.text = str(time.hour).pad_zeros(2)+":"+str(time.minute).pad_zeros(2)
	
	if Input.is_action_just_pressed("mb"):
		Audio.playSfx(heavyClick)
	if Input.is_action_just_pressed("CRT"):
		if $CRTShader.visible:
			$CRTShader.visible = false
		else:
			$CRTShader.visible = true
#	if Input.is_action_just_pressed("ui_focus_next"):
#		win()
	pass

func spamAds(amount):
	for i in amount:
		var window = WINDOW.instantiate()
		window.ad = true
		window.loadContent("res://Assets/ObjectScenes/popup.tscn")
		add_child(window)
		window.position = Vector2(randf_range(0,1000),randf_range(20,550))
	pass

func win():
	Audio.playMusic(load("res://Assets/Sounds/VaporJingle.wav"))
	var win = load("res://Assets/ObjectScenes/winScreen.tscn").instantiate()
	win.winScreen = true
	#window.loadContent("res://Assets/ObjectScenes/winScreen.tscn")
	add_child(win)
	win.position = Vector2(100,50)

func _on_StartButton_pressed():
	if $StartMenu.visible:
		$StartMenu.visible = false
	else:
		$StartMenu.visible = true
	pass # Replace with function body.


func _on_ShutDown_pressed():
	get_tree().quit()
	pass # Replace with function body.


func _on_Run_pressed():
	$StartMenu.hide()
	var window = WINDOW.instantiate()
	window.icon = "console"
	add_child(window)
	window.loadContent("res://Assets/ObjectScenes/console.tscn")
	window.setTitle("console")
	pass # Replace with function body.


func _on_Help_pressed():
	$StartMenu.hide()
	pass # Replace with function body.
