extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])
	
	#path = get_node("MobPath")
	#path_follow = path.get_node("MobSpawnLocation")
	# Set the mob's initial position to the start of the path
	#position = path_follow.get_transform().get_origin()
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# stats
var damage 		= 1
var speed  		= 1
var spawn_rate 	= 1

# setter functions
func set_damage(value):
	damage = value
func set_speed(value):
	speed = value
func set_spawn_rate(value):
	spawn_rate = value
