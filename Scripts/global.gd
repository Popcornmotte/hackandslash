extends Node


const MAXRAM = 16
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

func checkRam(r):
	if(ram+r <= MAXRAM):
		return true
	else:
		return false

func dmg(arg): #arg-format beispiel: "http:2"
	var args = arg.split(":")
	match args[0]:
		"http":
			var dmg = (4*int(args[1])+6)-firewall.httpRam*4
			if dmg >= 0:
				hp -= dmg
		"ssh":
			var dmg = (4*int(args[1])+6)-firewall.sshRam*4
			if dmg >= 0:
				hp -= dmg
		"ftp":
			var dmg = (4*int(args[1])+6)-firewall.ftpRam*4
			if dmg >= 0:
				hp -= dmg
	pinny.updateVis(hp)
	if hp <= 0:
		crash()

func sendDmg(arg):
	Network.sendText("dmg",arg)

func sendSpam(sec):
	var amount = 3
	if sec < 2:
		amount+=3
	elif sec < 4:
		amount+=1
	else:
		amount+=0
	Network.sendText("spam",str(amount))

func sendTip(port):
	Network.sendText("tip",port)

func win():
	desktop.win()

func crash():
	get_tree().change_scene("res://Scenes/Bluescreen.tscn")
	pass




