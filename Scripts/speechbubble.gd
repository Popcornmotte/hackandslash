extends Node2D

var dialogue#= ["das ist jetzt wohl die erste page schätze ich.", "und das hier scheint die zweite zu sein."]
var page = 0
var label
var clickSound = load("res://Assets/Sounds/singleKey.wav")
var running = false #fuer testzwecke direkt auf true
#var label = $Polygon2D/MarginContainer/RichTextLabel
func _ready():
	#visible = false
	#global.speechBox = self
	#$SpeechBubble/Text.visible_characters = 0
	#label.text = dialogue[page]
	#set_process_input(true)
	pass # Replace with function body.

func loadDialogue(var filepath) -> Dictionary:
	var file = File.new()
	assert(file.file_exists(filepath))
	file.open(filepath, file.READ);
#	var file2 = File.new()
#	file2.open(name, file2.WRITE_READ);
#	file2.store_string(to_json(file.get_as_text()))
#	var data = parse_json(file2.get_as_text())
#	if typeof(data) == TYPE_DICTIONARY:
#		dialogue = data
	dialogue = parse_json(file.get_as_text())
	running = true
	file.close()
	return dialogue
	pass

func start(var filepath):
	#global.inDialogue = true
	get_tree().paused = true
	global.desktop.get_node("CanvasModulate").show()
	Audio.playSfx(clickSound)
	$SpeechBubble/Text.visible_characters = 0
	visible = true
	running = true;
	$Timer.start();
	dialogue = loadDialogue(filepath);
	$SpeechBubble/Text.text = dialogue.get(str(page)).get("text")
	pass

func _process(_delta):
	if running:
#		$Polygon2D/Name.text = dialogue.get(str(page)).get("name");
#		$Polygon2D/Name/Portrait.play($Polygon2D/Name.text);
		if Input.is_action_just_pressed("ui_accept"):
			Audio.playSfx(clickSound)
			label = $SpeechBubble/Text
			page+=1
			dialogue.size()
			label.text = dialogue.get(str(page)).get("text") 
			if label.visible_characters >= label.get_total_character_count():
				#var temp = page
				if (page) < dialogue.size()-1:
					page+=1
					label.text = dialogue.get(str(page)).get("text") 
					label.visible_characters = 0
				else:
					visible = false;
#					global.inDialogue = false;
					#print(str(global.inDialogue))
					page = 0;
					label.visible_characters = 0;
					$Timer.stop();
					running = false;
					get_tree().paused = false
					global.desktop.get_node("CanvasModulate").hide()

			else:
				label.visible_characters = label.get_total_character_count();



func _on_Timer_timeout():
	$SpeechBubble/Text.visible_characters+=1
	#$AudioClick.play()
	pass # Replace with function body.
