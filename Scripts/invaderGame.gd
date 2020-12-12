extends Control

var count = 2



func win():
	pass
	
func lose():
	
	pass

func _ready():
	pass # Replace with function body.

func _on_LossDetector_area_entered(area):
	if("Invader" in area.name):
		lose()
	pass # Replace with function body.
