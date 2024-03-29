extends Node2D

class JumpLabel:
	var title : String
	var index : int

@export var debug = false

var codeFile : Userfile
var program = []
var labels = []
var valid = false
#0 OK, 1 UnkownOpCode, 2 WrongParams
var errorCode = 0
var errorLine

var id = ""

var direction = Vector2.UP

var instructionPointer = 0

#Register
var X = 0 #General-Purpose
var T = 0#General-Purpose, but also write/read dest of SPOT, CMP and JMP instr

# Called when the node enters the scene tree for the first time.
func _ready():
	if !is_in_group("Executors"):
		add_to_group("Executors")
	id = "drone"+str(global.drones.size())
	global.drones.append(self)
	$NameTag.text = id
	if codeFile == null:
		$Sprite.play("noProgram")
	else:
		loadProgram(codeFile)
	
	if debug:
		$DebugLabel.show()
	pass # Replace with function body.

func validate(file : Userfile) -> bool:
	var temp = file.content.split('\n',false)
	for t in temp:
		t = t.to_upper()
	var prog = []
	var i = -1
	for line in temp:
		i += 1
		var instr = line.split(' ',false)
		var instrSize = 0
		match instr[0]:
			#Math Instruction
			"COPY":
				instrSize = 3
			"ADDI":
				instrSize = 4
			"SUBI":
				instrSize = 4
			"MULI":
				instrSize = 4
			"DIVI":
				instrSize = 4
			"MODI":
				instrSize = 4
			#Logic Instructions
			"MARK":
				instrSize = 2
				var l = JumpLabel.new()
				l.title = instr[1]
				l.index = i
				labels.append(l)
			"JUMP":
				instrSize = 2
			"TJMP":
				instrSize = 2
			"FJMP":
				instrSize = 2
			"TEST":
				instrSize = 4
			#Peripheral Instructions
			"MOVE":
				instrSize = 1
			"TURN":
				instrSize = 2
			"FIRE":
				instrSize = 1
			"SPOT":
				instrSize = 1
			"AIMW":
				instrSize = 1
			_:
				errorLine = i+1
				errorCode = 1
				return false
		if instr.size() == instrSize:
			prog.append(instr)
		else:
			errorLine = i+1
			errorCode = 2
			return false
	program = prog
	return true

func loadProgram(code = null):
	if code:
		codeFile = code
	instructionPointer = 0
	valid = validate(codeFile)
	if valid:
		$Sprite.play("valid")
	else:
		$Sprite.play("invalid")

func runtimeError():
	debug = true
	$DebugLabel.show()
	valid = false
	$Sprite.play("invalid")
	$DebugLabel.set("theme_override_colors/font_color",Color.RED)
	#also return instruction pointer and so on bla bla

func readReg(reg : String):
	match reg:
		"X":
			return X
		"T":
			return T
		_:
			runtimeError()
			return 0
	pass

func writeReg(value, reg):
	match reg:
		"X":
			X = value
		"T":
			T = value
		_:
			runtimeError()
	pass

func incrIP():
	if instructionPointer < program.size()-1:
		instructionPointer+=1
	else:
		valid = false
		$Sprite.play("done")

func execute(instr):
	match(instr[0]):
		"COPY":
			var v
			if instr[1].is_valid_int():
				v = instr[1].to_int()
			else:
				v = readReg(instr[1])
			writeReg(v, instr[2])
			incrIP()
		"ADDI":
			var v1
			if instr[1].is_valid_int():
				v1 = instr[1].to_int()
			else:
				v1 = readReg(instr[1])
			var v2
			if instr[2].is_valid_int():
				v2 = instr[2].to_int()
			else:
				v2 = readReg(instr[2])
			writeReg((v1+v2), instr[3])
			incrIP()
		"SUBI":
			var v1
			if instr[1].is_valid_int():
				v1 = instr[1].to_int()
			else:
				v1 = readReg(instr[1])
			var v2
			if instr[2].is_valid_int():
				v2 = instr[2].to_int()
			else:
				v2 = readReg(instr[2])
			writeReg((v1-v2), instr[3])
			incrIP()
		"MULI":
			var v1
			if instr[1].is_valid_int():
				v1 = instr[1].to_int()
			else:
				v1 = readReg(instr[1])
			var v2
			if instr[2].is_valid_int():
				v2 = instr[2].to_int()
			else:
				v2 = readReg(instr[2])
			writeReg((v1*v2), instr[3])
			incrIP()
		"DIVI":
			var v1
			if instr[1].is_valid_int():
				v1 = instr[1].to_int()
			else:
				v1 = readReg(instr[1])
			var v2
			if instr[2].is_valid_int():
				v2 = instr[2].to_int()
			else:
				v2 = readReg(instr[2])
			writeReg((v1/v2), instr[3])
			incrIP()
		"MODI":
			var v1
			if instr[1].is_valid_int():
				v1 = instr[1].to_int()
			else:
				v1 = readReg(instr[1])
			var v2
			if instr[2].is_valid_int():
				v2 = instr[2].to_int()
			else:
				v2 = readReg(instr[2])
			writeReg((v1%v2), instr[3])
			incrIP()
		"MOVE":
			global_position += 32 * direction
			incrIP()
		"TURN":
			var v
			if instr[1].is_valid_int():
				v = instr[1].to_int()
			else:
				v = readReg(instr[1])
			if v < 0:
				direction = direction.rotated(deg_to_rad(-90))
				$Sprite.rotate(deg_to_rad(-90))
			elif v > 0:
				direction = direction.rotated(deg_to_rad(-90))
				$Sprite.rotate(deg_to_rad(90))
			incrIP()
		"FIRE":
			incrIP()
		"MARK":
			incrIP()
		"JUMP":
			var found = false
			for label in labels:
				if instr[1] == label.title:
					instructionPointer = label.index
					found = true
					break
			if !found:
				runtimeError()
		"TJMP":
			if readReg("T") == 1:
				var found = false
				for label in labels:
					if instr[1] == label.title:
						instructionPointer = label.index
						found = true
						break
				if !found:
					runtimeError()
			else:
				incrIP()
		"FJMP":
			if readReg("T") == 0:
				var found = false
				for label in labels:
					if instr[1] == label.title:
						instructionPointer = label.index
						found = true
						break
				if !found:
					runtimeError()
			else:
				incrIP()
		"SPOT":
			incrIP()
		"AIMW":
			incrIP()
	pass

func step():
	if valid:
		execute(program[instructionPointer])
		$Register.text = "X: "+str(X)+"\nT: "+str(T)
		if debug:
			var debugText = ""
			for s in program[instructionPointer]:
				debugText+=s+" "
			$DebugLabel.text = "Instr:\n"+debugText
	#elif debug:
	#	var debugText = ""
	#	for s in program[instructionPointer]:
	#		debugText+=s+" "
	#	$DebugLabel.text = "ERROR:\n"+debugText
		
		
