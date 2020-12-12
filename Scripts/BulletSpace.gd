extends Area2D

func _on_BulletSpace_area_exited(area):
	area.queue_free()
	pass
