extends Control


var heavyClick = preload("res://Assets/Sounds/heavyClick.wav")
var time
var jingle = preload("res://Assets/Sounds/loginJingle0.wav")
var wincount = 0
@export var useStaticWindows = false
@onready var StartMenu = $CanvasLayer/StartMenu
@onready var CRTShader = $ShaderCanvas/CRTShader
const ICON = preload("res://Assets/ObjectScenes/Icon.tscn") 
const WINDOW = preload("res://Assets/ObjectScenes/window.tscn")
const STATICWINDOW = preload("res://Assets/ObjectScenes/windowStatic.tscn")
const zeroPos = Vector2(256,100)

#these coords need to match the ones in window.gd!!!
const leftPos = Vector2i(0,0)
const rightPos= Vector2i(576,0)

const staticPos = [leftPos,rightPos]
func _ready():
	global.desktop = self
	CRTShader.show()
	Audio.playSfx(jingle)
	
	#create Icons of files loaded on startup
	for i in range(global.userfiles.size()):
		addIcon(i)
	#Input.set_custom_mouse_cursor(load("res://Assets/Sprites/mouse.png"),Input.CURSOR_ARROW)
	pass

func getpos(staticWindow = false):
	wincount+=1
	if staticWindow:
		return staticPos[(wincount+1)%2]
	else:
		$winPos.position=zeroPos+Vector2(wincount*5,wincount*5)
		return $winPos.position

func _process(delta):
	time = Time.get_datetime_dict_from_system()
	$Taskbar/Time/Label.text = str(time.hour).pad_zeros(2)+":"+str(time.minute).pad_zeros(2)
	
	if Input.is_action_just_pressed("mb"):
		Audio.playSfx(heavyClick)
	if Input.is_action_just_pressed("CRT"):
		if CRTShader.visible:
			CRTShader.visible = false
		else:
			CRTShader.visible = true
#	if Input.is_action_just_pressed("ui_focus_next"):
#		win()
	pass

func addIcon(index):
	var icon = ICON.instantiate()
	icon.title = global.userfiles[index].title
	icon.name = icon.title
	icon.icon = "file"
	icon.PROGRAM = "res://Assets/ObjectScenes/editor.tscn"
	$Icons.add_child(icon)
	icon.global_position = Vector2($Icons.global_position.x+(index%3)*64,$Icons.global_position.y+floor(index/3)*64)

#this is called by removeFile in global
func removeIcon(title : String):
	#remove Icon of a deleted file
	for child in $Icons.get_children():
		if child.title == title:
			child.queue_free()
			break
	#rearrange icons by new indices
	for i in range(global.userfiles.size()):
		var t = global.userfiles[i].title
		for child in $Icons.get_children():
			if child.title == t:
				child.global_position = Vector2($Icons.global_position.x+(i%3)*64,$Icons.global_position.y+floor(i/3)*64)

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
	if StartMenu.visible:
		StartMenu.visible = false
	else:
		#get_tree().call_group("Windows", "minimize", true)
		StartMenu.visible = true
		#$StartMenu/Buttons.grab_focus()
	pass # Replace with function body.


func _on_ShutDown_pressed():
	get_tree().quit()
	pass # Replace with function body.

#Open Console Button. formerly "Run .."
func _on_Run_pressed():
	StartMenu.hide()
	#Check if console window already open
	var miniIcons = $Taskbar/minimizedWindows.get_children()
	for m in miniIcons: 
		if m.name == "console":
			if m.minimized:
				m._on_Button_pressed()
			return
	#else open new console
	var window
	if useStaticWindows:
		window = STATICWINDOW.instantiate()
	else:
		window = WINDOW.instantiate()
	window.icon = "console"
	add_child(window)
	window.loadContent("res://Assets/ObjectScenes/console.tscn")
	window.setTitle("console")
	pass # Replace with function body.

func _on_editor_pressed():
	StartMenu.hide()
	#Check if console window already open
	var miniIcons = $Taskbar/minimizedWindows.get_children()
	for m in miniIcons: 
		if m.name == "file":
			if m.minimized:
				m._on_Button_pressed()
			return
	#else open new console
	var window
	if useStaticWindows:
		window = STATICWINDOW.instantiate()
	else:
		window = WINDOW.instantiate()
	window.icon = "file"
	add_child(window)
	window.loadContent("res://Assets/ObjectScenes/editor.tscn")
	window.setTitle("editor")
	pass # Replace with function body.
