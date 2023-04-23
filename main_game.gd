extends Node2D

# import mob/spawnlocations/mobspawnlocation<i>.tscn in IDE
@export var mob_path_1: PackedScene
@export var mob_path_2: PackedScene
@export var mob_path_3: PackedScene
#@export var TEST_MOB: PackedScene

var boat
var score
var difficulty
var base_difficulty = .01

func get_spawn_count():
	# TODO return variable spawn count from game state
	return floori(score/50) * ( 1 + floori(score * get_random_factor()) )

func get_random_factor(): # increase difficulty for longer game runs
	return randf_range(.0,difficulty*(1+score/100)/100)

func get_mob_scene(i):
	if i == 1:
		return mob_path_1 #"MobPath1/MobSpawnLocation1" #mob_path_1
	elif i == 2:
		return mob_path_2 #"MobPath2/MobSpawnLocation2" #mob_path_2
	else:
		return mob_path_3 #"MobPath3/MobSpawnLocation3" #mob_path_3

func get_mob_path(i):
	if i == 1:
		return get_node("MobPath1") #"MobPath1/MobSpawnLocation1" #mob_path_1
	elif i == 2:
		return get_node("MobPath2") #"MobPath2/MobSpawnLocation2" #mob_path_2
	else:
		return get_node("MobPath3") #"MobPath3/MobSpawnLocation3" #mob_path_3

# Called when the node enters the scene tree for the first time.
func _ready():
#	get_node("Emitter").connect("car_ready", self, "_on_Emitter_car_ready")
	get_node("enemy_spawn").ark_hit_1.connect(_on_path_1_ark_hit)
	get_node("enemy_spawn").ark_hit_2.connect(_on_path_2_ark_hit)
	get_node("enemy_spawn").ark_hit_3.connect(_on_path_3_ark_hit)
	get_node("Boat").destroyed.connect(_on_ark_destroyed)
	
	new_game(.5)

func new_game(dfclt):
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
	
	boat = get_node("Boat")
	score = 0
	difficulty = dfclt # TODO: adjust for game difficulty
	$start_game_sound.play()
	$StartTimer.start()

func game_over():
	if !$ScoreTimer.is_stopped():
		$ScoreTimer.stop()
	# TODO display nicely
	# start-new-game dialogue

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
		var spawn_index = randi_range(1,3)
		get_node("enemy_spawn").spawn(
			get_mob_scene( spawn_index ).instantiate(), # PathFollow2D
			1, # amount
			get_mob_path(spawn_index) # Path2D
		)
	# debug body with collision
#	var test_mob = TEST_MOB.instantiate()
#	get_node("TESTPATH")

func _on_score_timer_timeout():
	score += 1 + (difficulty - base_difficulty)
	pass # Replace with function body.


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	pass # Replace with function body.

################################################################################
## TODO complete
## signal functions from MobPath<i>/MobSpawnLocation<i> (i.e. the mob instances
##   from the various paths) when reaching end of path to hit and damage ark
## connect signals

func damage_ark(dmg):
	# TODO: decrease health of ark node
	boat.take_damage(dmg)
	get_node("Player/PlayerCamera/HealthArk").value = 100 - boat.health

func _on_ark_hit(dmg):
#	print(dmg)
	damage_ark(dmg)

func _on_path_1_ark_hit():
	_on_ark_hit(
		1  # TODO: get Mob1.damage
	)
	
func _on_path_2_ark_hit():
	_on_ark_hit(
		2 # TODO: get Mob2.damage
	)

func _on_path_3_ark_hit():
	_on_ark_hit(
		3 # TODO: get Mob3.damage
	)

func _on_ark_destroyed():
	$ScoreTimer.stop()
	game_over()
