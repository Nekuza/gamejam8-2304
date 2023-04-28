extends Node2D

# import mob/spawnlocations/mobspawnlocation<i>.tscn in IDE
@export var mob_path_1: PackedScene
@export var mob_path_2: PackedScene
@export var mob_path_3: PackedScene

# global game state variables
var boat
var score
var difficulty
var progress_counter
var target_progress

var config_file = "res://game.cfg"
var config
var base_difficulty
var spawn_divisor

# Called when the node enters the scene tree for the first time.
func _ready():
#	get_node("Emitter").connect("car_ready", self, "_on_Emitter_car_ready")
	get_node("enemy_spawn").ark_hit_1.connect(_on_path_1_ark_hit)
	get_node("enemy_spawn").ark_hit_2.connect(_on_path_2_ark_hit)
	get_node("enemy_spawn").ark_hit_3.connect(_on_path_3_ark_hit)
#	get_node("enemy_spawn").ark_hit_4.connect(_on_path_4_ark_hit)
#	get_node("enemy_spawn").ark_hit_5.connect(_on_path_5_ark_hit)
	get_node("Boat").destroyed.connect(_on_ark_destroyed)
	get_node("RigidBody2D").touched.connect(_on_animal_touched)
	
	# load game config
	config = ConfigFile.new()
	var err = config.load(config_file)
	if err != OK: # 43 is parsing error
		print("error while loading config file:")
		print(err)
		return

	############################################################################
	var mob2 = get_node("MobPath3/MobSpawnLocation3/Mob3/AnimatedSprite2D")
	var sprite_frames = mob2.sprite_frames
	# TODO save and load sprite_frames for dynamic loading depending on mob type
#	for section in config.get_sections():
#		if section.contains("animal"):
#			print(section.split(":")[1])
#		print(config.get_value(section,"key"))
#		for key in config.get_section_keys(section):
#			print(key)
	############################################################################

	base_difficulty = config.get_value("difficulty","base_difficulty")
	spawn_divisor = config.get_value("difficulty","spawn_divisor")

	new_game()

func new_game():
	var animal_loaded = preload("res://animal/logic/animal.tscn")
	# set up the different animal types for spawning
	var animals_array = []
	for section in config.get_sections():
		if section.contains("animal"):
			var animal = []
			animal.append(section.split(":")[1]) # animal_name
			for key in config.get_section_keys(section):
#				print(section,key)
				animal.append(config.get_value(section,key))
			animals_array.append(animal)
	for animal in animals_array:
		animal[2] = get_node(animal[2])
#	print(animals_array)

	# spawn animals in their spawn areas
	for animal in animals_array:
		var area = animal[2]
		for i in range(animal[1]):
			var instanciated_animal = animal_loaded.instantiate()
			instanciated_animal.animal_type = animal[0]
			instanciated_animal.position =area.position + Vector2(randf() * area.size.x, randf() * area.size.y)
			add_child(instanciated_animal)
	
	target_progress = len(animals_array)
	boat = get_node("Boat")
	score = 0
	difficulty = config.get_value("difficulty","difficulty")
	$start_game_sound.volume_db = config.get_value("start_sound","volume")
	$start_game_sound.play()
	$StartTimer.start()

func game_over():
	if !$ScoreTimer.is_stopped():
		$ScoreTimer.stop()
	# TODO display nicely
	# start-new-game dialogue

func game_won():
	if !$ScoreTimer.is_stopped():
		$ScoreTimer.stop()
	score += target_progress * 3 - (100 - boat.health)
	score *= 1 + base_difficulty

func progress_win_condition():
	progress_counter += 1
	check_win_condition()

func check_win_condition():
	if progress_counter >= target_progress:
		$ScoreTimer.stop()
		game_won()

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass

################################################################################
### Auxiliary functions
################################################################################
func get_spawn_count():
	# TODO return variable spawn count from game state
	return floori(score/spawn_divisor) * ( 1 + floori(score * get_random_factor()) )

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
	elif i == 3:
		return get_node("MobPath3")
	elif i == 4:
		return get_node("MobPath4")
	elif i == 5:
		return get_node("MobPath5")
	else:
		return get_node("MobPath3") #"MobPath3/MobSpawnLocation3" #mob_path_3

################################################################################
### Timers                                                                   ###
################################################################################
func _on_mob_timer_timeout():
	# TODO: edit to spawn different mobs per path
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
	damage_ark(dmg)

# TODO: remove code duplication with signals containing argument from mot type

func _on_path_1_ark_hit():
	_on_ark_hit(
		config.get_value("difficulty","base_damage") if config.get_section_keys("mob1").is_empty() else config.get_value("mob1","damage")
	)
	
func _on_path_2_ark_hit():
	_on_ark_hit(
		config.get_value("difficulty","base_damage") if config.get_section_keys("mob2").is_empty() else config.get_value("mob2","damage")
	)

func _on_path_3_ark_hit():
	_on_ark_hit(
		config.get_value("difficulty","base_damage") if config.get_section_keys("mob3").is_empty() else config.get_value("mob3","damage")
	)

func _on_path_4_ark_hit():
	_on_ark_hit(
		config.get_value("difficulty","base_damage") if config.get_section_keys("mob4").is_empty() else config.get_value("mob4","damage")
	)

func _on_path_5_ark_hit():
	_on_ark_hit(
		config.get_value("difficulty","base_damage") if config.get_section_keys("mob5").is_empty() else config.get_value("mob5","damage")
	)

func _on_ark_destroyed():
	$ScoreTimer.stop()
	game_over()

func _on_animal_touched():
	progress_win_condition()
	
