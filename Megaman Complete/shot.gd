extends "res://Hit.gd"

var dir #direction -1: left / 1: right
var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	isShot = true
	set_process(true)

func setDir(_dir):
	dir = _dir
	
func _process(delta):
	translate(Vector2(speed*delta*dir,0))
			
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

