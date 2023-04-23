extends PathFollow2D

signal ark_hit
var PRINT
# stats
var atk_damage 	= 1
var atk_speed	= 1
var speed  		= .5
var start_health = 40
@export var spawn_rate 	= 1
var health
var health_bar

#var mob = get_node("Mob").instantiate()
#var spawn_rate = mob.get_spawn_rate()
# Called when the node enters the scene tree for the first time.
func _ready():
	PRINT = true
	print("Mob1 ready!")
	health = start_health
	health_bar = get_node("Mob1").get_node("HealthBar")
	health_bar.max_value = health
	health_bar.value = health
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PRINT:
		print("I'm processing!")
		PRINT = false
		print(get_parent().name)
#		print(delta)
#		print(self.progress_ratio)
#		print($Mob1.speed)
	if progress_ratio > .99:
		ark_hit.emit()
		queue_free()
	
	
	self.progress_ratio += $Mob1.speed * delta # move mob without 
			# collision on path. mob moves straight and leaves path intermittently
			# but is bounced back to nearest path point on next tick
#	print("PathFollow2D")
#	print(self.get_poi)
#	progress_ratio += get_child(0).get_speed() * delta
#	pass

func on_hit(damage):
	health -= damage
	health_bar.value = health
	if health <= 0:
		on_destroy()
	else:
		$on_hit_sound.play() 
	
func on_destroy():
	#TODO death_sound
	self.queue_free()
