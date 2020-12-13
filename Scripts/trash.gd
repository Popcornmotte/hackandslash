extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameBox/AnimatedSprite.play(str(randi()%5))
	pass # Replace with function body.

func pause(b:bool):
	pass


#func _process(delta):
#	pass
