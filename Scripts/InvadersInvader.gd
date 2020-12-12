extends Area2D

var downSpeed = 10
var sideSpeed = 20
var dir = 1

func _process(delta):
	translate(Vector2(dir * sideSpeed * delta, downSpeed * delta))
	pass

func _on_Invader_area_entered(area):
	if("Bullet" in area.name):
		area.queue_free()
		queue_free()
	pass # Replace with function body.


func _on_Invader_area_exited(area):
	if("InvaderSpace" in area.name):
		dir *= -1
		translate(Vector2(-sideSpeed, 0))
	pass # Replace with function body.
