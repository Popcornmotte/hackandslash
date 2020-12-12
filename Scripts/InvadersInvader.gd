extends Area2D

var downSpeed = 0
var sideSpeed = 20
var dir = 1

func _process(delta):
	translate(Vector2(dir * sideSpeed * delta, downSpeed * delta))
	pass

func _on_Invader_area_entered(area):
	if("Bullet" in area.name):
		get_parent().count -= 1
		area.queue_free()
		global.invaderbullets -= 1
		get_parent().get_node("GameBox/BulletCounter").play(str(3-global.invaderbullets))
		queue_free()
	if "Wall" in area.name:
		sideSpeed *= -1
	pass # Replace with function body.

