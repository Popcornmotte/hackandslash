extends Control

var file : Userfile
var paused = false
@onready var code : CodeEdit = $NinePatchRect/CodeEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	code.text = file.content
	pass # Replace with function body.

func pause(b:bool):
	pass

func _on_save_button_pressed():
	file.content = code.text
	pass # Replace with function body.
