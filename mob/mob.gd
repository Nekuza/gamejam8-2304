extends RigidBody2D

# stats
var atk_damage 	= 1
var atk_speed	= 1
var speed  		= 10
@export var spawn_rate 	= 1
# var spawn_position = get_random_spawn_position()
@export var spawn_positions = [
	Vector2(0,0),
	Vector2(100,100),
	Vector2(450,337),
]

var path: Path2D
var path_follow: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	
	# select spawn_position from list of spawns
	position = spawn_positions[randi() % spawn_positions.size()]#get_random_spawn_position() ##spawn_position
	
	# TODO: get path to target (boat)
	#path = get_node("Path2D")
	#connect()
	
	#Path2D(
	#	spawn_position,
	#	Vector2(0,0)
	#	)
	#path = get_node("MobPath")
	#path_follow = path.get_node("MobSpawnLocation")
	# Set the mob's initial position to the start of the path
	#position = path_follow.get_transform().get_origin()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO: follow specified path
	path_follow = get_parent().get_node("MobPath/MobSpawnLocation")
	# path_follow = path.$MobSpawnLocation
	path_follow.position += Vector2(speed * delta, speed * delta)
	position = path_follow.get_global_transform().origin
	#if path_follow.offset >= path_follow.curve.get_baked_length():
	#	path_follow.offset = 0
	#var global_transform = path_follow.get_global_transform()
	#global_transform.origin = position
	#path_follow.set_global_transform(global_transform)
	# TODO: re-route path or deal damage if collision
	
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

func get_random_spawn_position():
	return spawn_positions[randi() % spawn_positions.size()]
	# TODO: get from runtime
	var minX = -100
	var maxX = 1440
	var minY = -100
	var maxY = 1550
	
	return Vector2(
		randi_range(minX,maxX),
		randi_range(minY,maxY)
		)
