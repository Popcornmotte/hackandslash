extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var icon = "trashbin"
export var PROGRAM : String
export var doubleClickTime = 0.3
export var title : String
var firstClick = false
var Window = load("res://Assets/ObjectScenes/window.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = title
	$doubleclickTimer.wait_time = doubleClickTime
	$AnimatedSprite.play(icon)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	if firstClick:
		var window = Window.instance()
		get_parent().get_parent().add_child(window)
		window.loadContent(PROGRAM)
		window.setTitle(title)
		firstClick = false
	else:
		firstClick = true
		$doubleclickTimer.start()
	pass # Replace with function body.


func _on_doubleclickTimer_timeout():
	firstClick = false
	pass # Replace with function body.
