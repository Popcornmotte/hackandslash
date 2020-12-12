extends Area2D

var downSpeed = 10
var sideSpeed = 20
var dir = 1

func _process(delta):
	translate(Vector2(sideSpeed * delta, downSpeed * delta))
	pass

func _on_Bullet_area_entered(area):
	area.queue_free()
	queue_free()
	pass

func _on_InvaderSpace_area_exited(area):
	dir *= -1
	translate(Vector2(0, sideSpeed))
	pass 
