extends Node2D

# import mob/spawnlocations/mobspawnlocation<i>.tscn in IDE
@export var mob_path_1: PackedScene
@export var mob_path_2: PackedScene
@export var mob_path_3: PackedScene
@export var TEST_MOB: PackedScene

var score

func get_spawn_count():
	# TODO return variable spawn count from game state
	return 3

func get_mob_scene(i):
	if i == 1:
		return mob_path_1 #"MobPath1/MobSpawnLocation1" #mob_path_1
	elif i == 2:
		return mob_path_2 #"MobPath2/MobSpawnLocation2" #mob_path_2
	else:
		return mob_path_3 #"MobPath3/MobSpawnLocation3" #mob_path_3

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
	# TODO: 
	for i in range(get_spawn_count()):
#		load("MobPath1/MobSpawnLocation1")
#		print("mob spawn in")
		var spawn_index = randi_range(1,3)
#		print(spawn_index)
		var mob_path = get_mob_scene( spawn_index )
		var mob_on_path = mob_path.instantiate()

		add_child(mob_on_path)
	var test_mob = TEST_MOB.instantiate()
	get_node("TESTPATH")
	print(test_mob)
#	add_child(test_mob)
	pass
#	var mob = mob_scene.instantiate()
#
#	#var mob_spawn_location = get_node("Mob/Spawn1")#get_random_spawn_position()
#	var mob_spawn_location = get_node("MobPath1/MobSpawnLocation1")
#	#get_node("MobSpawn1/MobSpawnLocation")
#	mob_spawn_location.progress_ratio = 0 #randf()
#
#	var direction = mob_spawn_location.rotation + 0 # PI / 2
#
#	mob.position = mob_spawn_location.position
#
#	direction += 0 #randf_range(-PI/4, PI/4)
#	mob.rotation = direction
#
#	var velocity = Vector2(
#		randf_range(150.0, 250.0),
#		0.0
#	)
#	mob.linear_velocity = velocity.rotated(direction)
#
#	add_child(mob)
#	pass # Replace with function body.



func _on_score_timer_timeout():
	score += 1
	pass # Replace with function body.


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.

################################################################################
## TODO complete
## signal functions from MobPath<i>/MobSpawnLocation<i> (i.e. the mob instances
##   from the various paths) when reaching end of path to hit and damage ark

func damage_ark(dmg):
	# TODO: decrease health of ark node
	pass
	
func _on_ark_hit(dmg):
	print("HIT!")
	damage_ark(dmg)
	pass # Replace with function body.

func _on_path_1_ark_hit():
	_on_ark_hit(
		# TODO: get Mob3.damage
		1#get_node("Mob").atk_damage
	)
	
func _on_path_2_ark_hit():
	_on_ark_hit(
		# TODO: get Mob3.damage
		1#get_node("Mob").atk_damage
	)

func _on_path_3_ark_hit():
	_on_ark_hit(
		# TODO: get Mob3.damage
		1#get_node("Mob").atk_damage
	)


