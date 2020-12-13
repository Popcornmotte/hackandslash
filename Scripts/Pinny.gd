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
	global.pinny = self
	$Carpet.play(str(-1))
	$Base.play(str(-1))
	$Eyes.play(str(-1))
	$DialogueManager/SpeechBubble.visible = false
	pass

func appearance():
	$Carpet.play(str(0))
	$Base.play(str(0))
	$Eyes.play(str(0))
	$DialogueManager/SpeechBubble.visible = true
	pass

func _on_AppearanceTimer_timeout():
	appearance()

func startHelpDialogue():
	$DialogueManager/SpeechBubble.visible = true
	$DialogueManager.start("res://Data/dialogue1.json")
	pass

func _on_X_button_down():
	$DialogueManager/SpeechBubble.visible = false
	$DialogueManager.stop()
	#$DialogueManager.start("res://Data/dialogue1.json")
	pass


func _on_Help_button_down():
	startHelpDialogue()
	pass # Replace with function body.
