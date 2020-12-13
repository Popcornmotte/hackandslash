extends Node2D

var existant = false
var margin1 = 40
var margin2 = 70

func updateVis(hp):
	if(hp > margin2):
		$Base.play(str(2))
		$Base.play(str(2))
		return
	if(hp > margin2):
		$Base.play(str(1))
		$Base.play(str(1))
	pass

func _ready():
	$Carpet.play(str(-1))
	$Base.play(str(-1))
	$Eyes.play(str(-1))
	$SpeechBubble.visible = false
	pass

func appearance():
	$Carpet.play(str(0))
	$Base.play(str(0))
	$Eyes.play(str(0))
	$SpeechBubble.visible = true
	pass

func _on_AppearanceTimer_timeout():
	appearance()


func _on_X_button_down():
	$SpeechBubble.visible = false
	pass
