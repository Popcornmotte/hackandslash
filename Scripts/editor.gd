extends Control

var file : Userfile
var paused = false
@onready var code : CodeEdit = $NinePatchRect/VBoxContainer/Editor/CodeEdit
@onready var fileList : ItemList = $NinePatchRect/VBoxContainer/Editor/ItemList
@onready var fileNameEdit : LineEdit = $NinePatchRect/VBoxContainer/FileNameBox/LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	for file in global.userfiles:
		fileList.add_item(file.title)
	if file:
		code.text = file.content
		code.editable = true
		fileNameEdit.text = file.title
	else:
		code.text = "No File selected. Load one or create new File."
		code.editable = false
	pass # Replace with function body.

func pause(b:bool):
	pass

func updateFileList():
	fileList.clear()
	for file in global.userfiles:
		fileList.add_item(file.title)

func saveFile():
	var renamed = false
	if file:
		file.content = code.text
		if fileNameEdit.text != file.title:
			if global.renameFile(file.title, fileNameEdit.text):
				renamed = true
			else:
				info("Name already taken!")
				return
		#re-get the file because renameing changes file instance
		file = global.getFile(fileNameEdit.text)
		updateFileList()
		global.saveGame()
		if renamed:
			info("File renamed and saved!")
		else:
			info("File saved!")
	else:
		info("No file to save! Create or load one first!")

func loadFile(title : String):
	code.editable = true
	file = global.getFile(title)
	if file:
		code.text = file.content
		fileNameEdit.text = file.title
	else:
		code.editable = false
		info("Error")

#displays a short info for 5 seconds
func info(text : String):
	var label = $NinePatchRect/VBoxContainer/Controls/HBox/InfoLabel
	label.text = text
	label.show()
	$InfoLabelTimer.start()

func _on_save_button_pressed():
	saveFile()
	pass # Replace with function body.

func _on_item_list_item_activated(index):
	saveFile()
	loadFile(fileList.get_item_text(index))
	info("File loaded!")
	pass # Replace with function body.
	
func _on_new_file_button_pressed():
	var text = ""
	if fileNameEdit.text == "":
		info("Enter a Filename!")
		return
	if global.newFile(fileNameEdit.text):
		info("Created new file with title '"+fileNameEdit.text+"'")
		loadFile(fileNameEdit.text)
		updateFileList()
	elif global.userfiles.size() >= global.MAXSTORAGE:
		text = "Disk storage full ("
		text += str(global.MAXSTORAGE)+"/"+str(global.MAXSTORAGE)+")."
		info(text)
	else:
		text = "File '"+fileNameEdit.text+"' already exists."
		info(text)
	pass # Replace with function body.


func _on_delete_button_pressed():
	if file:
		global.removeFile(file.title)
		file = null
		code.text = "No File selected. Load one or create new File."
		code.editable = false
		updateFileList()
		global.saveGame()
		info("File permanently removed!")
	else:
		info("Load a file first!")
	pass # Replace with function body.


func _on_timer_timeout():
	$NinePatchRect/VBoxContainer/Controls/HBox/InfoLabel.hide()
	pass # Replace with function body.
