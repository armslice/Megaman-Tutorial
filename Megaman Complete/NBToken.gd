extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$anim.play("get")
	yield($anim,"animation_finished")
	OS.shell_open("http://www.noisebridge.net")
	pass # Replace with function body.

func swollowPlayer():
	ref.player.stunned = true
	ref.player.get_node("anim").play("vanish")
