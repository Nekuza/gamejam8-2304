extends Node2D

var speed
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	var config = ConfigFile.new()
	config.load("res://game.cfg")
	var variation = config.get_value("mob3","speed_variation")
	speed = config.get_value("mob3","base_speed") + randf_range(-variation,variation)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	progress += speed * delta
	pass
