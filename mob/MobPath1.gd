extends Path2D

var points = [
		new Point2D(1304,328),
		new Point2D(1303,344),
		new Point2D(1224,342),
		new Point2D(1222,296),
		new Point2D(1082,295),
		new Point2D(1079,356),
		new Point2D(1033,359),
		new Point2D(1031,262),
		new Point2D(891,262),
		new Point2D(886,200),
		new Point2D(776,197),
		new Point2D(776,356),
		new Point2D(730,360),
		new Point2D(728,473)
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	# TODO set as global MobPath1 at res://main_game.tscn::Curve2D_3eo4t
#	get_node("")
#	self.Curve2D.Points = points
	print("ModPath1") # printed once
#	self.curve.Points[1]
#	print(self.curve.get_closest_point())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): # not running
	print("Mob/MobPath1")
	pass
