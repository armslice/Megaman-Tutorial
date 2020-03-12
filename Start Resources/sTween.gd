extends Tween


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var automatic = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_sTween_tree_entered():
	if automatic:
		start()
