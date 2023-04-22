extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn(enemy_type, amount, spawn_rate_time):
	$StaticBody2D/AnimatedSprite2D.play("open_gate")
	#TODO implement spawn
	pass
