extends Sprite2D

var maxDeg = 70
var turnL = 0
var turnR = 0
var currentDeg = 0
var turnfactor = 80
var bullet
var bulletSpeed = 150
var currentBullets = 0

func _ready():
	bullet = load("res://Assets/ObjectScenes/HackingGames/InvadersBullet.tscn")
	pass

func _process(delta):
	if !get_parent().get_parent().paused:
		if(Input.is_action_pressed("ui_left")):
			turnL = -turnfactor
		else:
			turnL = 0
		if(Input.is_action_pressed("ui_right")):
			turnR = turnfactor
		else:
			turnR = 0
		
		currentDeg = max(min(currentDeg + (turnR + turnL) * delta, maxDeg),-maxDeg)
		set_rotation(deg_to_rad(currentDeg))
		
		if(global.invaderbullets < 3 && Input.is_action_just_pressed("ui_accept")):
			global.invaderbullets += 1
			get_parent().get_node("BulletCounter").play(str(3-global.invaderbullets))
			var bulletInstance = bullet.instantiate()
			get_parent().get_parent().add_child(bulletInstance)
			bulletInstance.set_global_position($SpawnPos.global_position)
			bulletInstance.setVel(bulletSpeed * Vector2(cos(deg_to_rad(currentDeg-90)),sin(deg_to_rad(currentDeg-90))))
	
	pass

