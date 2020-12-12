extends MarginContainer

var sequence = []
var precounter = 0
var repcounter = 0

var topCooldown = 0.5
var inputCooldown = 5
var cooldown = 1
var phase = 0

var beep = preload("res://Assets/Sounds/beep.wav")

func _ready():
	randomize()
	pass

func _process(delta):
	match(phase):
		0:
			pass
		1:
			if(cooldown > 0):
				cooldown -= delta
			else:
				#print_debug("bleep, " + str(precounter))
				cooldown = topCooldown
				if(sequence.size() <= precounter):
					phase = 2
				else:
					if(precounter > 0): sequence[precounter-1].play(str(0))
					sequence[precounter].play(str(1))
					playsfx(precounter)
				precounter += 1
			pass
		2:
			sequence.back().play(str(0))
			cooldown = topCooldown
			phase = 3
			pass
		3:
			inputCooldown -= delta
			if(inputCooldown <= 0):
				phase = 1
				sequence.clear()
				topCooldown = 0.5
				precounter = 0
				repcounter = 0
				inputCooldown = 5
				sequence.append(getButton(randi()%4))
			pass
	pass

func win():
	get_parent().get_parent().get_parent().get_parent().queue_free()
	pass

func buttonInput(var index):
	inputCooldown = 5
	playsfx(index)
	if(sequence.size() > 0):
		if(sequence[repcounter] == getButton(index)):
			repcounter += 1
		else:
			repcounter = 0
		if(repcounter >= sequence.size()):
			if(sequence.size() >= 6):
				win()
				phase = 0
				return
			phase = 1
			repcounter = 0
			precounter = 0
			sequence.append(getButton(randi()%4))
			topCooldown = max(topCooldown-0.05, 0.1)
	pass

func getButton(var index):
	match(index):
		0:
			return $Box/alpha/icon
		1:
			return $Box/beta/icon
		2:
			return $Box/gamma/icon
		3:
			return $Box/delta/icon
	pass

func playsfx(var index):
	match(index):
		0:
			Audio.playSfx(beep)
		1:
			Audio.playSfx(beep)
		2:
			Audio.playSfx(beep)
		3:
			Audio.playSfx(beep)
	pass

func _on_alpha_button_down():
	$Box/alpha/icon.play(str(1))
	buttonInput(0)
	pass
	
func _on_alpha_button_up():
	$Box/alpha/icon.play(str(0))
	pass
	
func _on_beta_button_down():
	$Box/beta/icon.play(str(1))
	buttonInput(1)
	pass
	
func _on_beta_button_up():
	$Box/beta/icon.play(str(0))
	pass

func _on_gamma_button_down():
	$Box/gamma/icon.play(str(1))
	buttonInput(2)
	pass

func _on_gamma_button_up():
	$Box/gamma/icon.play(str(0))
	pass

func _on_delta_button_down():
	$Box/delta/icon.play(str(1))
	buttonInput(3)
	pass

func _on_delta_button_up():
	$Box/delta/icon.play(str(0))
	pass
	
func _on_start_button_down():
	phase = 1
	$Box/start.disabled = true
	sequence.append(getButton(randi()%4))
	pass