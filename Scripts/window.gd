extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragging = false
var pos : Vector2
var content
var CONTENT 
var icon = "trashbin"
const MINIICON = preload("res://Assets/ObjectScenes/miniIcon.tscn")
var miniIcon
export var windowName : String
export var test = false
export var testScene : String

# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().getpos()
	$OuterFrame/ProgramName.text = windowName
	miniIcon = MINIICON.instance()
	miniIcon.setWindow(self)
	miniIcon.setIcon(icon)
	#print(icon)
	get_parent().get_node("Taskbar/minimizedWindows").add_child(miniIcon)
	if test:
		loadContent(testScene)
	pass # Replace with function body.

func loadContent(c : String):
	CONTENT = load(c)
	content = CONTENT.instance()
	$OuterFrame/InnerFrame/WindowContent.add_child(content)

func setTitle(title):
	$OuterFrame/ProgramName.text = title

func setFocusField(b : bool):
	if b:
		$focusField.show()
	else:
		$focusField.hide()

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + pos
		if global_position.x < 0:
			global_position.x = 0
		if global_position.x > 1000:
			global_position.x = 1000
		if global_position.y < 0:
			global_position.y = 0
		if global_position.y > 580:
			global_position.y = 580
	pass

func close():
	get_parent().wincount -= 1
	miniIcon.kill()
	queue_free()
	

func _input(event):
	#set_input_as_handled()
	pass
	
func pauseContent(b:bool):
	if b:
		$OuterFrame/InnerFrame/WindowContent.get_child(0).pause(true)
		print("wuhuu")
	else:
		$OuterFrame/InnerFrame/WindowContent.get_child(0).pause(false)
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


func _on_CloseButton_pressed():
	close()
	pass # Replace with function body.


#func _on_focusField_button_down():
#	raise()
#	get_tree().set_input_as_handled()
#	if global.focusedWindow == self:
#		get_tree().set_input_as_handled()
#	if true:#global.clickable:
#		if global.focusedWindow != null:
#			global.focusedWindow.z_index = 0
#			#global.focusedWindow.setFocusField(true)
#		global.focusedWindow = self
#		get_parent().move_child(self,get_parent().get_child_count())
#		z_index = 10
		#$focusField.hide()
		#$focusField.grab_click_focus()
	pass # Replace with function body.




#func _on_focusField_mouse_entered():
#	#print("heyo")
#	global.clickable = false
#	pass # Replace with function body.
#
#
#func _on_focusField_mouse_exited():
#	global.clickable = true
#	pass # Replace with function body.


#func _on_OuterFrame_gui_input(event):
#	if "Button" in event.as_text():
#		raise()
#		if global.focusedWindow != self:
#			raise()
#			global.focusedWindow = self
#		else:
#			if global.focusedWindow != null:
#				get_tree().set_input_as_handled()
#	pass # Replace with function body.



