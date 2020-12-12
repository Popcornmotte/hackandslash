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

func _ready():
	pass 

func win():
	
	pass

func _process(delta):
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
	vel += dist * delta * 80/dist.length()
	
	$GameBox/SmallCircle.translate(delta * vel)
	
	if(dist.length()/32 < radius):
		streak += delta/64
		radius -= (delta + streak)/2
		$GameBox/LargeCircle.scale = Vector2(max(radius, winRadius),max(radius, winRadius))
	else:
		streak = 0
	
	if(radius <= winRadius):
		win()
	
	pass
