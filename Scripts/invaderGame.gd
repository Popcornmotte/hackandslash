extends Control

var count = 2
var paused = false

func win():
	pass
	
func lose():
	
	pass

func pause(b:bool):
	if b:
		paused = true
	else:
		paused = false

func _ready():
	pass # Replace with function body.

func _on_LossDetector_area_entered(area):
	if("Invader" in area.name):
		lose()
	pass # Replace with function body.
