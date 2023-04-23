extends RigidBody2D

@export_category("Select animal")
@export_enum("boris", "cow", "eagle", "goat", "pig", "wolf") 
var animal_type: String = "eagle"

var picked = false
var count = 0;

func _ready():
	$AnimatedSprite2D.play(animal_type)
	get_node("CollisionShape2D").disabled = false

func _physics_process(delta):
	if picked == true:
		self.position = get_node("../Player").position + Vector2(10, -23)

func _input(event):
	if Input.is_action_just_pressed("ui_pick") and picked == false:
		var bodies = $PickUpArea.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPick == true:
				picked = true
				get_node("CollisionShape2D").disabled = true
				$AnimatedSprite2D.stop()
				get_node("../Player").canPick = false
				count = 1

	elif Input.is_action_just_pressed("ui_pick") and picked == true and count == 1:
		get_node("../Player").canPick = true
		self.position = round(self.position)
		$AnimatedSprite2D.play(animal_type) 
		get_node("CollisionShape2D").disabled = false
		count = 0
		picked = false
