extends RigidBody2D

# stats
var atk_damage 	= 1
var atk_speed	= 1
var speed  		= 10
var start_health = 10
@export var spawn_rate 	= 1
# var spawn_position = get_random_spawn_position()
var spawn_positions = [
	Vector2(1304,327)#,
#	Vector2(20,0),
#	Vector2(100,100),
#	Vector2(450,337),
]
var path: Path2D
var path_follow: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	
	# TODO: test spawn_position
	#position = Vector2(450,337)#spawn_position
	
	# TODO: get path to target (boat)
	position = spawn_positions[randi() % spawn_positions.size()]
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
	path_follow = get_parent().get_node("MobPath1/MobSpawnLocation1")
	# path_follow = path.$MobSpawnLocation
	path_follow.position += Vector2(speed * delta, speed * delta)
	position = path_follow.get_global_transform().origin
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
