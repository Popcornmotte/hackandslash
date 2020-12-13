extends MarginContainer

var speed = 100
var radius = 4
var winRadius = .7
var xp = 0
var xn = 0
var yp = 0
var yn = 0
var vel : Vector2
var dist : Vector2
var streak = 0.0
var resets = 0
var paused = false
var sec = 0
func _ready():
	randomize()
	var newPos = Vector2(100-randi()%200,100-randi()%200)
	$GameBox/SmallCircle.position = $GameBox/LargeCircle.position + newPos.normalized() * 160
	pass 

func win():
	var bonus
	if sec < 3.5:
		bonus = 3
	elif sec < 5:
		bonus = 2
	else:
		bonus = 1
	global.sendDmg("http:"+str(bonus))
	
	get_parent().get_parent().get_parent().get_parent().close()
	pass

func reset():
	if(resets >= 2): win()
	resets += 1
	radius = 4-resets
	winRadius = .7 - (.1 * resets)
	var newPos = Vector2(100-randi()%200,100-randi()%200)
	$GameBox/SmallCircle.position = $GameBox/LargeCircle.position + newPos.normalized() * 160
	$GameBox/LargeCircle.scale = Vector2(radius,radius)
	$GameBox/TargetCircle.scale = Vector2(winRadius, winRadius)
	$GameBox/ProgressBar.value = resets
	vel = Vector2(0,0)
	pass

func pause(b:bool):
	if b:
		paused = true
	else:
		paused = false

func _process(delta):
	if !paused:
		
		sec += delta
		
		if(Input.is_action_pressed("ui_up")): yn = -1 
		else: yn = 0
		if(Input.is_action_pressed("ui_down")): yp = 1 
		else: yp = 0
		if(Input.is_action_pressed("ui_left")): xn = -1 
		else: xn = 0
		if(Input.is_action_pressed("ui_right")): xp = 1 
		else: xp = 0
		
		vel = lerp(vel, speed * Vector2(xp + xn, yp + yn), delta * 2)
		
		dist = $GameBox/SmallCircle.global_position - $GameBox/LargeCircle.global_position
		vel += dist * delta * (80 + resets * 10)/dist.length()
		
		if(dist.length() > 160):
			vel -= dist.normalized() * vel.length()
		$GameBox/SmallCircle.translate(delta * vel)
		
		if(dist.length()/32 < radius):
			streak += delta/64
			radius -= (delta + streak)/2
			$GameBox/LargeCircle.scale = Vector2(max(radius, winRadius),max(radius, winRadius))
		else:
			streak = 0
		
		if(radius <= winRadius):
			reset()
		
	pass
