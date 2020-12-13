extends MarginContainer

var allocatedRam = 0
var targetRot = 0
var currentRot = 0
var rotVel = 0
var paused = false

func _ready():
	global.hackradar = self

func setRam(var value):
	allocatedRam = value
	pass

func pause(b:bool):
	pass

func setTarget(var index):
	match(index):
		0:#ssh
			targetRot = 225
		1:#ftp
			targetRot = 0
		2:#http
			targetRot = 135
	pass

func _process(delta):
	rotVel += rand_range(-1, 1)
	rotVel = max(min(rotVel,8/(allocatedRam+1)),-8/(allocatedRam+1))
	currentRot += max(min(rotVel * delta * 10, 5*delta),-5*delta)
	$Box/Pointer.rotation_degrees = lerp($Box/Pointer.rotation_degrees + currentRot, targetRot, delta*(allocatedRam*allocatedRam)/4)
	pass


func _on_RAMup_button_down():
	if (allocatedRam < 8 && global.checkRam(1)):
		global.ram += 1
		allocatedRam += 1
		$Box/BarBackground/RAM.play(str(allocatedRam))
	pass

func _on_RAMdown_button_down():
	if (allocatedRam > 0):
		global.ram -= 1
		allocatedRam -= 1
		$Box/BarBackground/RAM.play(str(allocatedRam))
	pass
