extends Node2D

signal ark_hit_1
signal ark_hit_2
signal ark_hit_3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn(enemy_type: PathFollow2D, amount: int, mob_path: Path2D):
	for i in amount:
		mob_path.rotation = 0
#		print(enemy_type.name)
		if enemy_type.name == "MobSpawnLocation3":
			enemy_type.ark_hit.connect(_on_path_3_ark_hit)
		elif enemy_type.name == "MobSpawnLocation2":
			enemy_type.ark_hit.connect(_on_path_2_ark_hit)
		else:
			enemy_type.ark_hit.connect(_on_path_1_ark_hit)
		# TODO: missing hit -> fix signal
		mob_path.add_child(enemy_type)
		$StaticBody2D/AnimatedSprite2D.play("open_gate")
	#TODO implement spawn
	pass

func _on_path_1_ark_hit():
	ark_hit_1.emit()
func _on_path_2_ark_hit():
	ark_hit_2.emit()
func _on_path_3_ark_hit():
	ark_hit_3.emit()
