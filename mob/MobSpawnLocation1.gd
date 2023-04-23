extends PathFollow2D

signal ark_hit
signal move
var PRINT

#var mob = get_node("Mob").instantiate()
#var spawn_rate = mob.get_spawn_rate()
# Called when the node enters the scene tree for the first time.
func _ready():
	PRINT = true
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PRINT:
		PRINT = false
#		print(delta)
#		print(self.progress_ratio)
#		print($Mob1.speed)
	if progress_ratio > .99:
		ark_hit.emit()
		queue_free()
	
	
	self.progress_ratio += $Mob1.speed * delta # move mob without 
	move.emit()
			# collision on path. mob moves straight and leaves path intermittently
			# but is bounced back to nearest path point on next tick
#	print("PathFollow2D")
#	print(self.get_poi)
#	progress_ratio += get_child(0).get_speed() * delta
#	pass
