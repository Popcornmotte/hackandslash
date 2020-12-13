extends Control

var labelOrigin
var offset = 0

func _ready():
	labelOrigin = $MarginContainer/Polygon2D.position.x
	$MarginContainer/Polygon2D/Warning.visible = false
	pass


func _process(delta):
	$MarginContainer/ProgressBar.value = global.ram
	$MarginContainer/Polygon2D/Label.text = "Available RAM"\
	+" "+str(global.MAXRAM-global.ram)+"/"+str(global.MAXRAM)+" MB"
	pass

func notEnoughRam(missingRam):
	Audio.playSfx(load("res://Assets/Sounds/error.wav"))
	offset = 6
	$MarginContainer/Polygon2D/Warning.text = str(missingRam) + " MB more RAM required"
	$MarginContainer/Polygon2D/Warning.visible = true
	pass

func _on_Timer_timeout():
	if(abs(offset) > 0.1):
		$MarginContainer/Polygon2D.position.x = labelOrigin + offset
		offset -= 1.9 * offset
	else:
		$MarginContainer/Polygon2D.position.x = labelOrigin
		$MarginContainer/Polygon2D/Warning.visible = false
	pass


func _on_Button_button_down():
	notEnoughRam(4)
	pass # Replace with function body.
