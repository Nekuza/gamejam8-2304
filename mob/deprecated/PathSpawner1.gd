extends Path2D

#var timer = 0
#var follower = preload("res://mob/mob.tscn")
#var spawn_time
#var mob
var PRINT = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print("world/MobPath1 ready")
#	mob = follower.instantiate()
#	print(mob)
#	spawn_time = mob.spawn_rate#get_spawn_rate()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta): # running
	if PRINT:
		PRINT = false
		print("world/MobPath1 running")
#	timer += delta
#	if timer > spawn_time:
#		add_child(mob)
#		timer = 0
	pass
