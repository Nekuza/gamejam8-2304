extends RigidBody2D#CharacterBody2D

var speed = .01
var patrol_path#: NodePath
#var patrol_path
var patrol_points
var patrol_index = 0
var velocity = Vector2.ZERO

#var waypoint_index = 0
#var direction
#var target
#var destination

#func update_waypoints():
#	target = get_waypoint(waypoint_index)
#	waypoint_index += 1
#	destination = get_waypoint(waypoint_index)
#	direction = destination - target

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
#	patrol_path = NodePath(
#		get_tree().current_scene.get_path().get_concatenated_names() + "/TESTPATH"
#		)
	patrol_path = get_parent().get_patrol_path() # TODO: load path here?
#	print(patrol_path)
	if patrol_path.name != "TESTPATH":
#		print("not TESTPATH!\n")
#		print(get_tree().current_scene.get_path().get_concatenated_names())
		patrol_path = load("res//Mob2/TESTPATH.tres")
#		patrol_path = get_node("root/world/TESTPATH")
	print(patrol_path)
#	print(patrol_path.name)
#	print(
#		get_node(patrol_path)
#	)
	#.get_path_from_scene(
	#	get_node("../..")
	#)#get_node("../..") #.curve.get_baked_points()
	if patrol_path:
		patrol_points = patrol_path.curve.get_baked_points()
#	print(patrol_path.get_curre)
#	print(patrol_points)
#	update_waypoints()
	pass # Replace with function body.

func get_waypoint(i):
	return patrol_path.curve.get_baked_points()[i]

func get_last_node():
	return get_waypoint(-1)

#func direction():
#	pass

func _physics_process(delta):
#	move_and_slide()
#	move_and_collide(
#		direction
#	)
	if position.distance_to(get_last_node()) < 1:
		queue_free()
	var target = patrol_points[patrol_index]
	if position.distance_to(target) < 1:
		patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
		target = patrol_points[patrol_index]
	velocity = (target - position).normalized() * speed
#	print(velocity)
	velocity = move_and_collide(velocity)
#	print(velocity)
#	print("\n")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print( destination )
#	print( global_position )
#	print(safe_margin)
	
#	if global_position == destination:
#		update_waypoints()
##	var move_delta = speed * delta
#	scale *= 1.001
#	if scale.x > 2:
#		scale = Vector2(1,1)
	#Vector2(676,520)
	pass
