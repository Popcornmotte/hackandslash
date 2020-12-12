extends TextureRect



func _ready():
	$MarginContainer/VBoxContainer/Stats/http.play(str(global.httpRam))
	$MarginContainer/VBoxContainer/Stats/ftp.play(str(global.ftpRam))
	$MarginContainer/VBoxContainer/Stats/ssh.play(str(global.sshRam))
	pass 


func updateRam():
	global.checkRam()
	$MarginContainer/VBoxContainer/RAMavailable.value = global.ram
	$MarginContainer/VBoxContainer/Label.text = str(global.ram)+"/8 MB"

func _on_httpUp_pressed():
	if global.checkRam():
		global.httpRam += 1
		$MarginContainer/VBoxContainer/Stats/http.play(str(global.httpRam))
		updateRam()
	pass # Replace with function body.

func _on_httpDown_pressed():
	if global.httpRam > 0:
		global.httpRam -= 1
		$MarginContainer/VBoxContainer/Stats/http.play(str(global.httpRam))
		updateRam()
	pass # Replace with function body.

func _on_sshUp_pressed():
	if global.checkRam():
		global.sshRam += 1
		$MarginContainer/VBoxContainer/Stats/ssh.play(str(global.sshRam))
		updateRam()
	pass # Replace with function body.

func _on_sshDown_pressed():
	if global.sshRam > 0:
		global.sshRam -= 1
		$MarginContainer/VBoxContainer/Stats/ssh.play(str(global.sshRam))
		updateRam()
	pass # Replace with function body.

func _on_ftpUp_pressed():
	if global.checkRam():
		global.ftpRam += 1
		$MarginContainer/VBoxContainer/Stats/ftp.play(str(global.ftpRam))
		updateRam()
	pass # Replace with function body.

func _on_ftpDown_pressed():
	if global.ftpRam > 0:
		global.ftpRam -= 1
		$MarginContainer/VBoxContainer/Stats/ftp.play(str(global.ftpRam))
		updateRam()
	pass # Replace with function body.
