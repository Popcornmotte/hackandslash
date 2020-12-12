extends Area2D

var vel = Vector2(0,0)

func setVel(newVel):
	vel = newVel
	pass
	


func _ready():
	pass # Replace with function body.

func _process(delta):
	vel += Vector2(0,delta*50)
	translate(vel * delta)
	rotation = vel.angle() + deg2rad(90)
	pass

