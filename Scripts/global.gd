extends Node


const MAXRAM = 8
var username = "not_found"
var hp = 100
var httpRam = 0
var sshRam = 0
var ftpRam = 0
var ram = 0
var clickable = true
var invaderbullets = 0

var focusedWindow = null
var active_console
#onready var host_button = $HostButton
#onready var join_button = $JoinButton
#onready var status_ok = $StatusOk
#onready var status_fail = $StatusFail

func checkRam():
	ram = httpRam+ftpRam+sshRam
	if(ram < MAXRAM):
		return true
	else:
		return false



