extends Node

const SAVEFILE_NAME = "projectHackSlash.save"

const MAXRAM = 16
const MAXSTORAGE = 12 #MB?
var username = "not_found"
var hp = 100
var ram = 0
var clickable = true
var invaderbullets = 0
var desktop
var firewall
var hackradar
var pinny
var focusedWindow = null
var active_console

var userfiles : Array[Userfile]
var drones = []

func _ready():
	loadGame()

func makeSaveDict():
	
	var filenames = Array()
	var filecontents = Array()
	
	for file in userfiles:
		filenames.append(file.title)
		filecontents.append(file.content)
	
	var saveDict = {
		"filenames" : filenames,
		"filecontents" : filecontents,
		"username" : username,
	}
	return saveDict

func saveGame():
	var file = FileAccess.open_encrypted_with_pass(SAVEFILE_NAME, FileAccess.WRITE, "superorganism")
	file.store_string(JSON.stringify(makeSaveDict()))
	file.close()

#param(dict): the JSON dictionary object returned parsed from saveFile
#param(value): the Global variable that should be set to the data from the savefile
#param(data): the data name to be fetched from the json dict
func loadDataFromDictSafe(dict, value, data : String):
	var temp = dict.get(data)
	if(temp != null):
		return temp
	else:
		printerr("[Global.loadDataFromDictSafe] dict.get("+data+") returned null")
		return value

func loadGame():
	if FileAccess.file_exists(SAVEFILE_NAME):
		var file = FileAccess.open_encrypted_with_pass(SAVEFILE_NAME, FileAccess.READ, "superorganism")
		#file.open(FILE_NAME, File.READ)
		var dict = JSON.parse_string(file.get_as_text())
		#var data = parse_json(file.get_as_text())
		file.close()
		
		var filenames = Array()
		var filecontents = Array()
		
		if typeof(dict) == TYPE_DICTIONARY:
			filenames = loadDataFromDictSafe(dict, filenames, "filenames")
			filecontents = loadDataFromDictSafe(dict, filecontents, "filecontents")
			for i in range(filenames.size()):
				userfiles.append(Userfile.new(filenames[i], filecontents[i]))
			username = loadDataFromDictSafe(dict,username,"username")
			#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(masterVolume))
			#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(musicVolume))
			#AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Effects"), linear_to_db(effectsVolume))
		else:
			printerr("Corrupted data!")
	else:
		saveGame();
		printerr("No saved data!")

func newFile(title : String) -> bool:
	if userfiles.size() < MAXSTORAGE:
		for file in userfiles:
			if title == file.title:
				return false
		userfiles.append(Userfile.new(title))
		desktop.addIcon(userfiles.size()-1)
		return true
	else:
		return false

func renameFile(oldTitle : String, newTitle : String)->bool:
	for file in userfiles:
			if newTitle == file.title:
				return false
	var temp = getFile(oldTitle)
	removeFile(oldTitle)
	newFile(newTitle)
	var new = getFile(newTitle)
	new.content = temp.content
	return true

func removeFile(title : String)->bool:
	var index = -1
	var ret = false
	for file in global.userfiles:
		index += 1
		if file.title == title:
			global.userfiles.remove_at(index)
			ret = true
			break
	if(ret):
		desktop.removeIcon(title)
	return ret

func getFile(title : String):
	for file in userfiles:
		if file.title == title:
			return file
	return null

func win():
	desktop.win()

func crash():
	get_tree().change_scene_to_file("res://Scenes/Bluescreen.tscn")
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		get_tree().call_group("Executors", "step")
	if Input.is_action_just_pressed("ui_up"):
		if $Timer.is_stopped():
			$Timer.start(1)
		else:
			$Timer.stop()




func _on_timer_timeout():
	get_tree().call_group("Executors", "step")
	pass # Replace with function body.
