extends PathFollow2D

signal ark_hit
var speed = .3

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress_ratio > .99:
		ark_hit.emit()
		queue_free()
	
	
	progress_ratio += $Mob3.speed * delta
	pass
