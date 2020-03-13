extends Node2D


onready var console = $Modal/DebugConsole/Label
onready var player = $Player
onready var camera = $Camera
onready var lifebar = $Modal/LifeBar
onready var spawnPoint = $Level/spawnPoint.global_position

var pitYLevel = 225
var debugText = ""
var opening = true

func _ready():
	set_process(true)
	set_process_input(true)
	add_child(tools.timer(self,4,"endSplash",[]))
	get_tree().paused = true
	player.position = $Level/spawnPoint.global_position
	
	
func _process(delta):
	debugConsole()
	
	if opening:
		if Input.is_action_just_pressed("any"):
			if is_instance_valid($Modal/splash):
				$Modal/splash.queue_free()
			else:
				if is_instance_valid($Modal/instructions):
					$Modal/instructions.queue_free()
					opening = false
					get_tree().paused = false
			

func debug(strings):
	if !typeof(strings) == TYPE_ARRAY:
		strings = [strings]
	debugText+="\n"
	for s in strings:
		debugText +=str(s)+" "
	
func debugConsole():
	console.text = debugText
	debugText = ""

func _input(event):
	if event.is_action_pressed("toggleDebug"):
		print("console toggled")
		$Modal/DebugConsole.visible = !$Modal/DebugConsole.visible
		
func endSplash():
	if is_instance_valid($Modal/splash):
		$Modal/splash.queue_free()
