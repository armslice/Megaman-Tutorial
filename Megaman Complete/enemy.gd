extends "res://Character.gd"

export var mobName = ""
var defending = false
var defenseTimer = null
var ticker = tools.loop(self,1,"tick",[],0)

# Called when the node enters the scene tree for the first time.
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
	if !$holeCheck.get_collider() or $blockCheck.get_collider() and !$blockCheck.get_collider() == ref.player:
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
	$Hit/CollisionShape2D.disabled = true
	$sprite.animation = "stand"
	if defenseTimer:
		defenseTimer.stop()
		remove_child(defenseTimer)
	defenseTimer = tools.counter(4)
	add_child(defenseTimer)
	yield(defenseTimer,"timeout")
	$Hit/CollisionShape2D.disabled = false
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
