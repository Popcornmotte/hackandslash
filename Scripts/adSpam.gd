extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var vram
var text
var line = 0
var sec = 0
const FILEPATH = "res://Data/hackercode.txt"
# Called when the node enters the scene tree for the first time.
func _ready():
	grab_focus()
	var file = File.new()
	assert(file.file_exists(FILEPATH))
	file.open(FILEPATH, file.READ);
	text = file.get_as_text()
	$NinePatchRect/Output.text = text
	$NinePatchRect/Output.visible_characters = 0
	#$NinePatchRect/Output.scroll_following = true
	pass # Replace with function body.

func win():
	global.sendSpam(sec)
	get_parent().get_parent().get_parent().get_parent().close()

func _process(delta):
	sec += delta
	if $NinePatchRect/Output.visible_characters >= 1232:
		win()

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode != KEY_ENTER:
			$NinePatchRect/Output.visible_characters += 5
			#line += 1
			#$NinePatchRect/Output.scroll_to_line(line)

