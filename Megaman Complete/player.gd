extends "res://Character.gd" #inherits all variables and funtions of Character

var maxJumpHold = .5
var jumpHold = maxJumpHold
var jumpPow = 100
var canJump = true
var shot = preload("res://Shot.tscn")
var shooting = false
var shootTimer = null
var maxLife = 10.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera.limit_bottom = ref.game.pitYLevel
	$anim.play("reset")
	type = "player"
	life = maxLife
	set_process(true)
	pass # Replace with function body.

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
				canJump=false #disables jumpHold during freefall
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
			#Refreshes the collision to fix for concecutive collisions
			#when the player is still standing in the hit area

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
	jumpHold)+"\nCanJump: "+str(
	canJump)+", Shooting: "+str(shooting)+"\nStunned: "+str(
		stunned
	)
	

