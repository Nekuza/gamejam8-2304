extends Node2D

signal ark_hit_1
signal ark_hit_2
signal ark_hit_3

func _ready():
#	get_parent().get_node("MobPath1/MobSpawnLocation1")._on_path_1_ark_hit.connect(ark_hit_1)
	pass

func spawn(enemy_type: PathFollow2D, amount: int, mob_path: Path2D):
	enemy_type.add_to_group("enemies")
	for i in amount:
		mob_path.rotation = 0
		if enemy_type.name == "MobSpawnLocation3":
			enemy_type.ark_hit.connect(_on_path_3_ark_hit)
		elif enemy_type.name == "MobSpawnLocation2":
			enemy_type.ark_hit.connect(_on_path_2_ark_hit)
		else:
			enemy_type.ark_hit.connect(_on_path_1_ark_hit)
			$StaticBody2D/AnimatedSprite2D.play("open_gate")
		mob_path.add_child(enemy_type)
		# TODO: play spawn sound?

func ready_enemy(mob_name,param):
	var config = ConfigFile.new()
	config.load("res://game.cfg")
	if param == "speed": # special case for speed
		return get_enemy_speed(mob_name)
	return config.get_value(mob_name,param)

func get_enemy_speed(mob_name):
	var config = ConfigFile.new()
	config.load("res://game.cfg")
	var variation = config.get_value(mob_name,"speed_variation")
	var speed = config.get_value(mob_name,"base_speed") + randf_range(-variation,variation)
	return speed
	

func _on_path_1_ark_hit():
	ark_hit_1.emit()
func _on_path_2_ark_hit():
	ark_hit_2.emit()
func _on_path_3_ark_hit():
	ark_hit_3.emit()
