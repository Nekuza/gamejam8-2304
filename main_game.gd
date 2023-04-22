extends Node2D

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()
	
func new_game():
	var animal_loaded = preload("res://animal/logic/animal.tscn")
	# set up the different animal types for spawning
	var animals_array = [
	["cow", 4, $animal_spawn_top],
	["boris", 3, $animal_spawn_topLeft],
	["eagle", 2, $animal_spawn_bottomLeft],
	["goat", 5, $animal_spawn_right],
	["pig", 4, $animal_spawn_left],
	["wolf", 3, $animal_spawn_bottom]
	]
		
	# spawn animals in their spawn areas
	for animal in animals_array:
		var area = animal[2]
		for i in range(animal[1]):
			var instanciated_animal = animal_loaded.instantiate()
			instanciated_animal.animal_type = animal[0]
			instanciated_animal.position =area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
			add_child(instanciated_animal)
	
	score = 0
	$start_game_sound.play()
	#$Player.start($StartPosition.position)
	$StartTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass


################################################################################
### Timers                                                                   ###
################################################################################
func _on_mob_timer_timeout():
	var mob = mob_scene.instantiate()
	
	#var mob_spawn_location = get_node("Mob/Spawn1")#get_random_spawn_position()
	var mob_spawn_location = get_node("MobPath1/MobSpawnLocation1")
	#get_node("MobSpawn1/MobSpawnLocation")
	mob_spawn_location.progress_ratio = 0 #randf()
	
	var direction = mob_spawn_location.rotation + 0 # PI / 2
	
	mob.position = mob_spawn_location.position
	
	direction += 0 #randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	var velocity = Vector2(
		randf_range(150.0, 250.0),
		0.0
	)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)
#	pass # Replace with function body.


func _on_score_timer_timeout():
	score += 1
	pass # Replace with function body.


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.
