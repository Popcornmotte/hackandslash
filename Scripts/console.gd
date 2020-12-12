extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var out = $NinePatchRect/Output
onready var input = $NinePatchRect/Input
var clack = load("res://Assets/Sounds/singleKey.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	$NinePatchRect/Input.grab_focus()
	pass # Replace with function body.

func parse(s : String):
	out.text = str(out.text,"\n",s)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Input_text_entered(new_text):
	parse(new_text)
	input.clear()
	Audio.playSfx(clack)
	pass # Replace with function body.
