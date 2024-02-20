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
	rotation = vel.angle() + deg_to_rad(90)
	pass



func _on_Bullet_area_entered(area):
	if "Wall" in area.name:
		global.invaderbullets -= 1
		get_parent().get_node("GameBox/BulletCounter").play(str(3-global.invaderbullets))
		queue_free()
	pass # Replace with function body.
