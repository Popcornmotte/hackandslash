extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@onready var out = $NinePatchRect/VBox/Output
@onready var input = $NinePatchRect/VBox/Input
var clack = load("res://Assets/Sounds/singleKey.wav")
var paused = false
var allocatedRam = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	global.active_console = self
	$NinePatchRect/VBox/Input.grab_focus()
	var text = "Welcome "+global.username+"\n"\
	+"OS: remOS\n"\
	+"Kernel: "+OS.get_name()+"\n"\
	+"DCMI: "+OS.get_system_dir(OS.SYSTEM_DIR_DCIM)+"\n"\
	+"Locale: "+OS.get_locale()+"\n\n"\
	+"type 'help' to get help"
	printout(text)
	pass # Replace with function body.

func pause(b:bool):
	pass

func printout(s):
	out.text = str(out.text,"\n",s)
	out.scroll_vertical = 99999


func help():
	var text = "Commands:\n"\
	+"help: this\n"\
	+"touch [Filename] : Create a new file\n"\
	+"ls : List all files\n"\
	+"cat [Filename] : Print content of a file\n"\
	+"rm [Filename] : Remove a file permanently\n"\
	+"upload [Filename] [Drone]: Uploads a codefile to a drone\n"
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
		"ls":
			if global.userfiles.size() > 0:
				text += "Files in user directory:\n"
				for file in global.userfiles:
					text += file.title + "\n"
			else:
				text = "No Files in user directory."
		"touch":
			if cmd.size() >= 2:
				if global.newFile(cmd[1]):
					text = "Created new file with title '"+cmd[1]+"'\n"
				elif global.userfiles.size() < global.MAXSTORAGE:
					text = "Disk storage at maximum capacity ("
					text += str(global.MAXSTORAGE)+"/"+str(global.MAXSTORAGE)+").\n"
				else:
					text = "Error: File '"+cmd[1]+"' already exists.\n"
			else:
				text = "Wrong number of arguments!\n"
		"cat":
			if cmd.size() >= 2:
				for file in global.userfiles:
					if file.title == cmd[1]:
						text += "Content of file '"+file.title+"': \n"
						text += file.content +"\n"
						break
		"rm":
			if cmd.size() >= 2:
				if global.removeFile(cmd[1]):
					text = "Removed file.\n"
				else:
					text = "File '"+cmd[1]+"' not found.\n"
		"upload":
			if cmd.size() == 3:
				for file in global.userfiles:
					if file.title == cmd[1]:
						for drone in global.drones:
							if drone.id == cmd[2]:
								drone.loadProgram(file)
								if drone.errorCode == 0:
									text = "Program uploaded!"
								else:
									if drone.errorCode == 1:
										text = "line "+str(drone.errorLine)+": Unknown OpCode"
									if drone.errorCode == 2:
										text = "line "+str(drone.errorLine)+": Wrong Params"
								break
						break
			else:
				text = "Wrong number of arguments!\n"
		
		"chat":
			if cmd.size() >= 2:
				cmd.remove(0)
				text = global.username+": "
				for x in cmd:
					text+=x+" "
				#Network.sendText("chat",text)
		_:
			help()
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
