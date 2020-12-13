extends Control

var count = 2
var paused = false
var sec = 0

func win():
	var bonus
	if sec < 3.5:
		bonus = 3
	elif sec < 5:
		bonus = 2
	else:
		bonus = 1
	global.sendDmg("ssh:"+str(bonus))
	global.ram += 4
	get_parent().get_parent().get_parent().get_parent().close()
	pass
	
func lose():
	pass

func pause(b:bool):
	if b:
		paused = true
	else:
		paused = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if count > 0:
		sec += delta

func _on_LossDetector_area_entered(area):
	if("Invader" in area.name):
		lose()
	pass # Replace with function body.
