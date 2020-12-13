extends Node


const MAXRAM = 16
var username = "not_found"
var hp = 100
var ram = 0
var clickable = true
var invaderbullets = 0
var desktop
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
			hp -= 4*int(args[1])
		"ssh":
			hp -= 4*int(args[1])
		"ftp":
			hp -= 4*int(args[1])
	if hp <= 0:
		crash()

func sendDmg(arg):
	Network.sendText("dmg",arg)

func win():
	desktop.win()

func crash():
	get_tree().change_scene("res://Scenes/Bluescreen.tscn")
	pass




