extends Node2D

var speed = .05

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = randf_range(.01,speed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	progress += speed * delta
	pass
