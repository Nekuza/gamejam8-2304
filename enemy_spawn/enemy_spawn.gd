extends Node2D

signal ark_hit_1
signal ark_hit_2
signal ark_hit_3

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
		mob_path.add_child(enemy_type)
		$StaticBody2D/AnimatedSprite2D.play("open_gate")
		# TODO: play spawn sound?

func _on_path_1_ark_hit():
	ark_hit_1.emit()
func _on_path_2_ark_hit():
	ark_hit_2.emit()
func _on_path_3_ark_hit():
	ark_hit_3.emit()
