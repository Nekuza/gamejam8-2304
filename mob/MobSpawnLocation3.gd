extends PathFollow2D

signal ark_hit
var PRINT
# stats
var atk_damage 	= 10
var atk_speed	= 1
var speed  		= 5
var start_health = 200
@export var spawn_rate 	= 0.3
var health
var health_bar

# Called when the node enters the scene tree for the first time.
func _ready():
	PRINT = true
	print("Mob3 ready!")
	health = start_health
	health_bar = get_node("Mob3").get_node("HealthBar")
	health_bar.max_value = health
	health_bar.value = health
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if progress_ratio > .99:
		ark_hit.emit()
		queue_free()
	progress_ratio += $Mob3.speed * delta
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
