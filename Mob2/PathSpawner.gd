extends Path2D

var timer = 0
var spawn_time = 1

var follower = preload("res://Mob2/CharacterFollower.gd")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer += delta
	
	if timer > spawn_time:
		var new_follower = follower.new()
#		instantiate()
		add_child(new_follower)
		timer = 0
