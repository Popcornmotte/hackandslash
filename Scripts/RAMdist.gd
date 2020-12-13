extends Sprite

var dragging = false
var pos : Vector2
const MINIICON = preload("res://Assets/ObjectScenes/miniIcon.tscn")
var miniIcon
var icon = "firewall"

var httpRam = 0
var sshRam = 0
var ftpRam = 0

func checkFRam():
	if (httpRam+sshRam+ftpRam < 8 && global.checkRam(1)):
		return true
	else:
		return false

func _ready():
	global.firewall = self
	$MarginContainer/VBoxContainer/Stats/http.play(str(httpRam))
	$MarginContainer/VBoxContainer/Stats/ftp.play(str(ftpRam))
	$MarginContainer/VBoxContainer/Stats/ssh.play(str(sshRam))
	miniIcon = MINIICON.instance()
	miniIcon.setWindow(self)
	get_parent().get_node("Taskbar/minimizedWindows").add_child(miniIcon)
	pass 


func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + pos
	pass


func updateRam():
	#checkFRam()
	$MarginContainer/VBoxContainer/RAMavailable.value = httpRam+sshRam+ftpRam
	$MarginContainer/VBoxContainer/Label.text = str(httpRam+sshRam+ftpRam)+"/8 MB"

func _on_httpUp_pressed():
	if checkFRam():
		httpRam += 1
		global.ram += 1
		$MarginContainer/VBoxContainer/Stats/http.play(str(httpRam))
		updateRam()
	pass # Replace with function body.

func _on_httpDown_pressed():
	if httpRam > 0:
		httpRam -= 1
		global.ram -= 1
		$MarginContainer/VBoxContainer/Stats/http.play(str(httpRam))
		updateRam()
	pass # Replace with function body.

func _on_sshUp_pressed():
	if checkFRam():
		sshRam += 1
		global.ram += 1
		$MarginContainer/VBoxContainer/Stats/ssh.play(str(sshRam))
		updateRam()
	pass # Replace with function body.

func _on_sshDown_pressed():
	if sshRam > 0:
		sshRam -= 1
		global.ram -= 1
		$MarginContainer/VBoxContainer/Stats/ssh.play(str(sshRam))
		updateRam()
	pass # Replace with function body.

func _on_ftpUp_pressed():
	if checkFRam():
		ftpRam += 1
		global.ram += 1
		$MarginContainer/VBoxContainer/Stats/ftp.play(str(ftpRam))
		updateRam()
	pass # Replace with function body.

func _on_ftpDown_pressed():
	if ftpRam > 0:
		ftpRam -= 1
		global.ram -= 1
		$MarginContainer/VBoxContainer/Stats/ftp.play(str(ftpRam))
		updateRam()
	pass # Replace with function body.


func pauseContent(b:bool):
	pass

func _on_Button_button_down():
	raise()
	get_tree().set_input_as_handled()
	if true:#global.clickable:
		if global.focusedWindow != null:
			global.focusedWindow.z_index = 0
			global.focusedWindow.pauseContent(true)
			print(str(global.focusedWindow))
		global.focusedWindow = self
		pauseContent(false)
		z_index = 10
	dragging = true
	pos = global_position - get_global_mouse_position()
	pass # Replace with function body.


func _on_Button_button_up():
	dragging = false
	pass # Replace with function body.
