extends Node

const MAXRAM = 8
var username = "not_found"
var hp = 100
var httpRam = 0
var sshRam = 0
var ftpRam = 0
var ram = 0

func checkRam():
	ram = httpRam+ftpRam+sshRam
	if(ram < MAXRAM):
		return true
	else:
		return false
