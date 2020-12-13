extends Node


const MAXRAM = 16
var username = "not_found"
var hp = 100
var ram = 0
var clickable = true
var invaderbullets = 0

var focusedWindow = null
var active_console

func checkRam(r):
	if(ram+r <= MAXRAM):
		return true
	else:
		return false




