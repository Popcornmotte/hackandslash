extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var text
const FILEPATH = "res://Data/bluescreen.txt"
# Called when the node enters the scene tree for the first time.
func _ready():
	var file = File.new()
	assert(file.file_exists(FILEPATH))
	file.open(FILEPATH, file.READ);
	text = file.get_as_text()
	$CanvasLayer/RichTextLabel.text =text
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
