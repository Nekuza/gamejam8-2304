extends Node2D

# stats
var atk_damage 	= 1
var atk_speed	= 1
var speed  		= .5
var start_health = 10
@export var spawn_rate 	= 1
var health

# var spawn_position = get_random_spawn_position()

var spawn_positions = [
	Vector2(1304,327)#,
#	Vector2(20,0),
#	Vector2(100,100),
#	Vector2(450,337),
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var health = start_health
	var health_bar = get_node("HealthBar")
	health_bar.max_value = health
	health_bar.value = health
	# health_bar.set_as_toplevel(true) to not rotate the healthbar, needs change in movefunc of enemy, because it also disconnects the position
	
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	
	# TODO: test spawn_position
#	position = get_random_spawn_position()#spawn_positions[randi() % spawn_positions.size()]
	# TODO: get path to target (boat)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO: follow specified path
#	path_follow = get_parent().get_node("MobPath1/MobSpawnLocation1")
#	# path_follow = path.$MobSpawnLocation
#	path_follow.position += Vector2(speed * delta, speed * delta)
#	position = path_follow.get_global_transform().origin
	pass


# setter functions
func set_damage(value):
	atk_damage = value
func set_atk_speed(value):
	atk_speed = value
func set_speed(value):
	speed = value
func set_spawn_rate(value):
	spawn_rate = value

func on_hit(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		on_destroy()
	#else
		# TODO hit_sound 
	
func on_destroy():
	#TODO death_sound
	self.queue_free()

func get_random_spawn_position():
	return spawn_positions[randi() % spawn_positions.size()]
