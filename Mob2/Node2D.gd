extends CharacterBody2D

var speed = .03
var waypoint_index = 0
var direction
var target
var destination

func update_waypoints():
	target = get_waypoint(waypoint_index)
	waypoint_index += 1
	destination = get_waypoint(waypoint_index)
	direction = destination - target

# Called when the node enters the scene tree for the first time.
func _ready():
	update_waypoints()
	pass # Replace with function body.

func get_waypoint(i):
	return get_parent().get_parent().curve.get_baked_points()[i]

func get_last_node():
	return get_waypoint(-1)

#func direction():
#	pass

func _physics_process(delta):
#	move_and_slide()
	move_and_collide(
		direction
	)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print( destination )
#	print( global_position )
#	print(safe_margin)
	if global_position == destination:
		update_waypoints()
#	var move_delta = speed * delta
	scale *= 1.001
	if scale.x > 2:
		scale = Vector2(1,1)
	#Vector2(676,520)
	pass
