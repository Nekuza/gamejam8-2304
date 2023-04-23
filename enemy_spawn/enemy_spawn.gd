extends Node2D

signal ark_hit

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn(enemy_type: PathFollow2D, amount: int, mob_path: Path2D):
	for i in amount:
		mob_path.rotation = 0
		enemy_type.ark_hit.connect(_on_path_ark_hit)
		# TODO: missing hit -> fix signal
		mob_path.add_child(enemy_type)
		$StaticBody2D/AnimatedSprite2D.play("open_gate")
	#TODO implement spawn
	pass

func _on_path_ark_hit():
	ark_hit.emit()
