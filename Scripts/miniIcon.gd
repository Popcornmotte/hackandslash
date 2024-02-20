extends MarginContainer


@export var type : String
var minimized = false
var window

func _ready():
	
	$Button/AnimatedSprite2D.play(window.icon)
	#print(window.icon)
	pass # Replace with function body.

func setWindow(x):
	window = x
	$Button/AnimatedSprite2D.play(window.icon)

func setIcon(i):
	$Button/AnimatedSprite2D.play(i)

func kill():
	queue_free()


func _on_Button_pressed():
	if minimized:
		minimized = false
		window.show()
	else:
		minimized = true
		window.hide()
	pass # Replace with function body.
