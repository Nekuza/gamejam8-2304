extends PathFollow2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	move(delta)
	
func move(delta)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	var move_delta = $Node2D.speed * delta
#	self.move_local_x(move_delta)
#	self.move_local_y(move_delta)
	# TODO: remove child when reached certain position
#	if $Node2D.global_position == get_parent().curve.get_baked_points()[-1]:
#		remove_child($Node2D)
	
#	if $Node2D/RigidBody2D.get_contact_count() > 0:
#		print("COLLISION!")
#	pass
