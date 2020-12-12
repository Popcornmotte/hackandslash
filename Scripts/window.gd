extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dragging = false
var pos : Vector2
var content
var CONTENT 
export var windowName : String
export var test = false
export var testScene : String
# Called when the node enters the scene tree for the first time.
func _ready():
	position = get_parent().getpos()
	$OuterFrame/ProgramName.text = windowName
	if test:
		loadContent(testScene)
	pass # Replace with function body.

func loadContent(c : String):
	CONTENT = load(c)
	content = CONTENT.instance()
	$OuterFrame/InnerFrame/WindowContent.add_child(content)

func setTitle(title):
	$OuterFrame/ProgramName.text = title

func _process(delta):
	if dragging:
		global_position = get_global_mouse_position() + pos
	pass

func close():
	get_parent().wincount -= 1
	queue_free()

func _on_Button_button_down():
	dragging = true
	pos = global_position - get_global_mouse_position()
	pass # Replace with function body.


func _on_Button_button_up():
	dragging = false
	pass # Replace with function body.


func _on_CloseButton_pressed():
	close()
	pass # Replace with function body.
