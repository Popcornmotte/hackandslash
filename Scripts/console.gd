extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var out = $NinePatchRect/Output
onready var input = $NinePatchRect/Input
var clack = load("res://Assets/Sounds/singleKey.wav")
# Called when the node enters the scene tree for the first time.
func _ready():
	global.active_console = self
	$NinePatchRect/Input.grab_focus()
	var text = "Welcome to Hack&&/\n"\
	+"OS: Macrohard Doors 95\n"\
	+"Sub-OS: "+OS.get_name()+"\n"\
	+"DCMI: "+OS.get_system_dir(OS.SYSTEM_DIR_DCIM)+"\n"\
	+"Locale: "+OS.get_locale()+"\n\n"\
	+"type 'help' to get help"
	printout(text)
	pass # Replace with function body.

func printout(s):
	out.text = str(out.text,"\n",s,"\n")
puppet func remotePrintout(s):
	out.text = str(out.text,"\n",s,"\n")

func help():
	var text = "Commands:\n"\
	+"help: this\n"\
	+"host [IP] [PORT] : Host a match\n"\
	+"join [IP] [PORT] : Join a match\n"
	printout(text)

func parse(s : String):
	var text = ""
	#out.text = str(out.text,"\n",s)
	var cmd = s.split(" ")
	match cmd[0]:
		"help":
			help()
		"?":
			help()
		"host":
			if cmd.size() == 3 or cmd.size() == 2:
				global.address = cmd[1]
				if cmd.size() == 3:
					global.port = int(cmd[2])
				else:
					global.port = global.DEFAULT_PORT
				global._on_host_pressed()
				text = global.status
			else:
				text = "Too few/much arguments!\nUsage:\nhost [IP] [PORT]\n"\
				+"leave [PORT] empty for default_port"
		"join":
			if cmd.size() == 3 or cmd.size() == 2:
				global.address = cmd[1]
				if cmd.size() == 3:
					global.port = int(cmd[2])
				else:
					global.port = global.DEFAULT_PORT
				global._on_join_pressed()
				text = global.status
			else:
				text = "Too few/much arguments!\nUsage:\njoin [IP] [PORT]\n"\
				+"leave [PORT] empty for default_port"
		"chat":
			if cmd.size() >= 2:
				cmd.remove(0)
				text = global.username+": "
				for s in cmd:
					text+=s+" "
				rpc("remoteprintout",text)
	printout(text)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Input_text_entered(new_text):
	parse(new_text)
	input.clear()
	Audio.playSfx(clack)
	pass # Replace with function body.