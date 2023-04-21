extends RigidBody2D

# stats
var damage 		= 1
var speed  		= 1
var spawn_rate 	= 1
var spawn_position = get_random_spawn_position()

var path: Path2D
var path_follow: PathFollow2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	
	# TODO: test spawn_position
	# if spawn_position is illegal:
	#	pass
	# else:
	position = Vector2(450,337)#spawn_position
	
	# TODO: get path to target (boat)
	path = get_node("Path2D")
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
	# TODO: re-route path or deal damage if collision
	pass


# setter functions
func set_damage(value):
	damage = value
func set_speed(value):
	speed = value
func set_spawn_rate(value):
	spawn_rate = value

func get_random_spawn_position():
	# TODO: get from runtime
	var minX = -100
	var maxX = 1440
	var minY = -100
	var maxY = 1550
	
	return Vector2(
		randi_range(minX,maxX),
		randi_range(minY,maxY)
		)
