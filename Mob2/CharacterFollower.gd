extends PathFollow2D

@export var  run_speed = .02
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	progress_ratio += run_speed * delta
#	v_offset += run_speed * delta
