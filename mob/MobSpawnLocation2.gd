extends PathFollow2D

signal ark_hit
var PRINT
# stats
var atk_damage
var atk_speed
var speed
@export var spawn_rate = 1
var health
var health_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	atk_damage	= get_child(0).atk_damage
	atk_speed	= get_child(0).atk_speed
	health		= get_child(0).health
	spawn_rate	= get_child(0).spawn_rate
	speed		= get_child(0).speed
	health_bar = get_node("Mob2").get_node("HealthBar")
	health_bar.max_value = health
	health_bar.value = health
	
	PRINT = true
	print("Mob2 ready!")
	print(speed)
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress_ratio > .99:
		ark_hit.emit()
		queue_free()
	progress_ratio += speed * delta
	pass

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
