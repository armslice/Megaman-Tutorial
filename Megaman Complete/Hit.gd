extends Area2D

export var power = 1 #how much damage to target body
export var targetType = "player"
export var isShot = false

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	if body.get("type"): #makes contact with a Character
		if body.type == targetType:
			body.hit(power)
	if isShot:
		queue_free()
