extends Node2D

var atk_damage
var atk_speed
var health
var spawn_rate
var speed


# Called when the node enters the scene tree for the first time.
func _ready():
	self.freeze = true
	var config = ConfigFile.new()
	config.load("res://game.cfg")
	var mob_name = "mob2"
	atk_damage 		= ready_enemy(mob_name,"atk_damage")
	atk_speed 		= ready_enemy(mob_name,"atk_speed")
	health 			= ready_enemy(mob_name,"health")
	spawn_rate 		= ready_enemy(mob_name,"spawn_rate")
	speed 			= ready_enemy(mob_name,"speed")
#	var variation = config.get_value("mob3","speed_variation")
#	speed = config.get_value("mob3","base_speed") + randf_range(-variation,variation)
	pass # Replace with function body.

# TODO: move to enemy_spawn.gd for global calling
func ready_enemy(mob_name,param):
	var config = ConfigFile.new()
	config.load("res://game.cfg")
	if param == "speed": # special case for speed
		return get_enemy_speed(mob_name)
	return config.get_value(mob_name,param)

# TODO: move to enemy_spawn.gd for global calling
func get_enemy_speed(mob_name):
	var config = ConfigFile.new()
	config.load("res://game.cfg")
	var variation = config.get_value(mob_name,"speed_variation")
	var speed = config.get_value(mob_name,"base_speed") + randf_range(-variation,variation)
	return speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
