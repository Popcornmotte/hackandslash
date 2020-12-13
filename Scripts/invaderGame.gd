extends Control

var count = 3
var paused = false
var sec = 0
var allocatedRam = 4
var enemy = preload("res://Assets/ObjectScenes/HackingGames/InvadersInvader.tscn")

func checkWin():
	if(count <= 0):
		win()
	pass

func win():
	Audio.playSfx(load("res://Assets/Sounds/accept.wav"))
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
	spawnEnemy()
	spawnEnemy()
	spawnEnemy()
	pass
	
func spawnEnemy():
	var newEnemy = enemy.instance()
	add_child(newEnemy)
	newEnemy.position = Vector2(rand_range(20,340),rand_range(20,200))
	pass

func _process(delta):
	if count > 0:
		sec += delta

func _on_LossDetector_area_entered(area):
	if("Invader" in area.name):
		lose()
	pass # Replace with function body.
