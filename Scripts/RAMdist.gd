extends Sprite

var dragging = false
var pos : Vector2
const MINIICON = preload("res://Assets/ObjectScenes/miniIcon.tscn")
var miniIcon
var icon = "firewall"

func _ready():
	$MarginContainer/VBoxContainer/Stats/http.play(str(global.httpRam))
	$MarginContainer/VBoxContainer/Stats/ftp.play(str(global.ftpRam))
	$MarginContainer/VBoxContainer/Stats/ssh.play(str(global.sshRam))
	miniIcon = MINIICON.instance()
	miniIcon.setWindow(self)
	get_parent().get_node("Taskbar/minimizedWindows").add_child(miniIcon)
	pass 


func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + pos
	pass


func updateRam():
	global.checkRam()
	$MarginContainer/VBoxContainer/RAMavailable.value = global.ram
	$MarginContainer/VBoxContainer/Label.text = str(global.ram)+"/8 MB"

func _on_httpUp_pressed():
	if global.checkRam():
		global.httpRam += 1
		$MarginContainer/VBoxContainer/Stats/http.play(str(global.httpRam))
		updateRam()
	pass # Replace with function body.

func _on_httpDown_pressed():
	if global.httpRam > 0:
		global.httpRam -= 1
		$MarginContainer/VBoxContainer/Stats/http.play(str(global.httpRam))
		updateRam()
	pass # Replace with function body.

func _on_sshUp_pressed():
	if global.checkRam():
		global.sshRam += 1
		$MarginContainer/VBoxContainer/Stats/ssh.play(str(global.sshRam))
		updateRam()
	pass # Replace with function body.

func _on_sshDown_pressed():
	if global.sshRam > 0:
		global.sshRam -= 1
		$MarginContainer/VBoxContainer/Stats/ssh.play(str(global.sshRam))
		updateRam()
	pass # Replace with function body.

func _on_ftpUp_pressed():
	if global.checkRam():
		global.ftpRam += 1
		$MarginContainer/VBoxContainer/Stats/ftp.play(str(global.ftpRam))
		updateRam()
	pass # Replace with function body.

func _on_ftpDown_pressed():
	if global.ftpRam > 0:
		global.ftpRam -= 1
		$MarginContainer/VBoxContainer/Stats/ftp.play(str(global.ftpRam))
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
