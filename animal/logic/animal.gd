extends RigidBody2D

@export_category("Select animal")
@export_enum("boris", "cow", "eagle", "goat", "pig", "wolf") 
var animal_type: String = "eagle"

var picked = false

func _ready():
	$AnimatedSprite2D.play(animal_type)

func _physics_process(delta):
	if picked == true:
		self.position = get_node("../Player").position + Vector2(0, -30)
		print(self.position)

func _input(event):
	if Input.is_action_just_pressed("ui_pick"):
		var bodies = $PickUpArea.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPick == true:
				picked = true
				get_node("CollisionShape2D").disabled = true
				$AnimatedSprite2D.stop()
				get_node("../Player").canPick = false
				
				
	if Input.is_action_just_pressed("ui_release") and picked == true:
		picked = false
		get_node("../Player").canPick = true
		self.position = round(get_node("../Player").position + Vector2(30, 0))
		$AnimatedSprite2D.play(animal_type) 
		get_node("CollisionShape2D").disabled = false
		
		print("Losgelassen")
	
func _process(delta):
		pass
	
