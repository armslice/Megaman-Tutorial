# Game.gd

extends Node2D

onready var console = $Modal/DebugConsole/Label
onready var player = $Player
onready var camera = $Camera
onready var lifebar = $Modal/LifeBar
onready var spawnPoint = $Level/spawnPoint.position

var pitYLevel = 225
var debugText = ""
var cameraFollowPlayer = true
var opening = true

func _ready():
	set_process(true)
	set_process_input(true)
	camera.limit_bottom = pitYLevel
	add_child(tools.timer(self,4,"endSplash",[]))
	get_tree().paused = true
	player.position = $Level/spawnPoint.position
	
	
func _process(delta):
	if cameraFollowPlayer:
		camera.position = player.position
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


# Character.gd

extends KinematicBody2D

onready var frontFoot = $frontFoot
onready var backFoot = $backFoot

export var dir = 1 &#35direction -1: left / 1: right
export var speed = 10
export var life = 1
export var type = ""
var vel = Vector2() &#35creates a 2 demsional point at 0,0
var friction = .9
const gravity = 7
const maxVelX = 200
const maxVelY = 300
var onGround = false
var debugVar = ""
var hitTimer = null
var invincible = false
var stunned = false

&#35 Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	pass &#35 Replace with function body.

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
	

# Player.gd

extends "res://Character.gd" &#35inherits all variables and funtions of Character

var maxJumpHold = .5
var jumpHold = maxJumpHold
var jumpPow = 75
var canJump = true
var shot = preload("res://Shot.tscn")
var shooting = false
var shootTimer = null
var maxLife = 10.0

&#35 Called when the node enters the scene tree for the first time.
func _ready():
	$anim.play("reset")
	type = "player"
	life = maxLife
	set_process(true)

func _process(delta):
	ref.game.debug(self)
	
	if position.y> ref.game.pitYLevel+20:
		life=0
		ref.game.lifebar.value = life/maxLife * 100
		die()

	if not stunned:
		var shootAnim = "shoot_" if shooting else ""
		
		if Input.is_action_pressed("ui_left"):
				vel += Vector2(-speed,0)
				$sprite.flip_h = true
				dir = -1
				if $shootSpot.position.x > 1:
					$shootSpot.position.x *=-1
		if Input.is_action_pressed("ui_right"):
				vel += Vector2(speed,0)
				$sprite.flip_h = false
				dir = 1
				if $shootSpot.position.x <1:
					$shootSpot.position.x *=-1
					
		if Input.is_action_just_pressed("shoot") and !shooting:
			shoot()
			$sprite.animation = "shoot_"+$sprite.animation
				
		if onGround:
			canJump = true
			jumpHold = 0
			if canJump and Input.is_action_just_pressed("jump"):
				vel.y = -150
			else:
				if abs(vel.x)>10:
					$sprite.animation = shootAnim+"walk"
				else:
					$sprite.animation = shootAnim+"stand"
			$shootSpot.position.y = -14
		else:
			if vel.y>0:
				canJump=false &#35disables jumpHold during freefall
			if canJump and jumpHold<maxJumpHold and Input.is_action_pressed("jump"):
				jumpHold += delta
				vel.y += -jumpPow
			if Input.is_action_just_released("jump"):
				canJump = false
			if sign(vel.y)==-1:
				$sprite.animation = shootAnim+"jump"
			else:
				$sprite.animation = shootAnim+"fall"
			$shootSpot.position.y = -22
			
func shoot():
	var s = shot.instance()
	s.setDir(dir)
	s.position = $shootSpot.global_position
	ref.game.add_child(s)
	shooting = true
	shootTimer = tools.counter(.4)
	add_child(shootTimer)
	yield(shootTimer,"timeout")
	shooting = false
	
func hit(power):
	if !invincible:
		stunned = true
		invincible = true
		vel.x = -200
		$anim.play("hit")
		life-=power
		ref.game.lifebar.value = life/maxLife * 100
		yield($anim,"animation_finished")
		if life <=0:
			die()
		else:
			stunned = false	
			invincible = false
			$CollisionShape2D.disabled = true
			$CollisionShape2D.disabled = false 
			&#35Refreshes the collision to fix for concecutive collisions
			&#35when the player is still standing in the hit area

func die():
	$sprite.animation = "die"
	stunned = true
	invincible = true
	var t = tools.counter(1)
	add_child(t)
	yield(t,"timeout")
	$anim.play("reset")
	stunned = false
	invincible = false
	life = maxLife
	ref.game.lifebar.value = life/maxLife * 100
	position = ref.game.spawnPoint
	vel = Vector2()
	t.stop()
	remove_child(t)
	dir = 1
	$sprite.flip_h = false
		
func _to_string():
	return name+", onground: "+str(
	onGround)+", jumpHold: "+str(
	jumpHold)+", Vel: "+str(vel.floor())+"\nCanJump: "+str(
	canJump)+", Shooting: "+str(shooting)+"\nStunned: "+str(
		stunned
	)

# Hit.gd

extends Area2D

export var power = 1 &#35how much damage to target body
export var targetType = "player"
export var isShot = false

func _ready():
	pass &#35 Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get("type"): &#35makes contact with a Character
		if body.type == targetType:
			body.hit(power)
	if isShot:
		queue_free()



# shot.gd

extends "res://Hit.gd"

var dir &#35direction -1: left / 1: right
var speed = 200

&#35 Called when the node enters the scene tree for the first time.
func _ready():
	isShot = true
	set_process(true)

func setDir(_dir):
	dir = _dir
	
func _process(delta):
	translate(Vector2(speed*delta*dir,0))
			
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

# enemy.gd

extends "res://Character.gd"

export var mobName = ""
var defending = false
var defenseTimer = null
var ticker = tools.loop(self,1,"tick",[],0)

&#35 Called when the node enters the scene tree for the first time.
func _ready():
	speed = 7
	life = 3
	type = "enemy"
	if dir == -1:
		dir=1
		changeDir()
	set_process(true)
	add_child(ticker)
	
func _process(delta):
	ref.game.debug(self)
	
	if life>0 and !defending:
		if onGround and !stunned:
			walk()
	
	if abs(vel.x)>3:
		$sprite.animation = "walk"
		if mobName == "met":
			invincible = false
	else:
		$sprite.animation = "stand"
		if mobName == "met":
			invincible = true

func tick():
	if !defending:
		randomize()
		if randf()<.1:
			defend()

func walk():
	vel.x += speed*dir
	if !$holeCheck.get_collider() or $blockCheck.get_collider():
		changeDir()

func changeDir():
	dir *=-1
	$holeCheck.position *=-1
	$blockCheck.position.x *=-1
	$blockCheck.cast_to *=-1
	$sprite.flip_h = !$sprite.flip_h

func defend():
	invincible = true
	defending = true
	$sprite.animation = "stand"
	if defenseTimer:
		defenseTimer.stop()
		remove_child(defenseTimer)
	defenseTimer = tools.counter(4)
	add_child(defenseTimer)
	yield(defenseTimer,"timeout")
	defenseTimer = null
	invincible = false
	defending = false

func die():
	$Hit/CollisionShape2D.disabled = true
	$sprite.playing = false
	var fade = tools.fadeOut(self,.3)
	add_child(tools.lTween($sprite,"scale",$sprite.scale,Vector2(0,1),.3,0))
	add_child(fade)
	yield(fade,"tween_completed")
	queue_free()

func hit(power):
	if !invincible:
		invincible = true
		stunned = true
		$anim.play("hit")
		life-=power
		yield($anim,"animation_finished")
		invincible = false
		stunned = false
		if life <= 0:
			die()
	defend()
	
func _to_string():
	return name+" life: "+str(life)+" stunned: "+str(
		stunned)+" invincible: "+str(invincible)