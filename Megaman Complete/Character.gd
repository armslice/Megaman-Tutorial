extends KinematicBody2D

onready var frontFoot = $frontFoot
onready var backFoot = $backFoot

export var dir = 1 #direction -1: left / 1: right
export var speed = 10
export var life = 1
export var type = ""
var vel = Vector2() #creates a 2 demsional point at 0,0
var friction = .9
const gravity = 7
const maxVelX = 200
const maxVelY = 300
var onGround = false
var debugVar = ""
var hitTimer = null
var invincible = false
var stunned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass # Replace with function body.

func _process(delta):
	onGround = frontFoot.is_colliding() or backFoot.is_colliding()
	if !onGround:
		if vel.y>-1:
			vel.y = clamp(vel.y+gravity,-maxVelY,maxVelY)
		else:
			vel.y*=.6
	
	vel.x = clamp(vel.x,-maxVelX,maxVelX)	
	vel = move_and_slide(vel,Vector2(0,-1)) 
	
	vel.x*=friction
	if abs(vel.x)<3:
		vel.x = 0	
		
func hit(power):
	pass
			
	
func die():
	pass
	
