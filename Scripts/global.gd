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
		
func crash():
	get_tree().change_scene("res://Scenes/Bluescreen.tscn")
	pass




