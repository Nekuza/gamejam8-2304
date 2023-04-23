extends RigidBody2D

@export_category("Select animal")
@export_enum("boris", "cow", "eagle", "goat", "pig", "wolf") 
var animal_type: String = "eagle"

# tower stats
var damage = 1
var rateOfFire = 500


var enemies_inRange = []
var tageted_enemy
var picked = false
var isTouched = false
var count = 0
var readyToFire = true

func _ready():
	$AnimatedSprite2D.play(animal_type)
	get_node("CollisionShape2D").disabled = false

func _physics_process(delta):
	if picked:
		self.position = get_node("../Player").position + Vector2(10, -23)
	if enemies_inRange.size() != 0 and isTouched and !picked:
		select_enemy()
		look_at(tageted_enemy.position)
		if readyToFire:
			fire()
	else:
		tageted_enemy = null


func _input(event):
	if Input.is_action_just_pressed("ui_pick") and !picked:
		var bodies = $PickUpArea.get_overlapping_bodies()
		for body in bodies:
			if body.name == "Player" and get_node("../Player").canPick == true:
				picked = true
				isTouched = true
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

func select_enemy():
	var enemy_progress_array = []
	for i in enemies_inRange:
		enemy_progress_array.append(i.get_progress())
	var max_progress = enemy_progress_array.max()
	var enemy_index = enemy_progress_array.find(max_progress)
	tageted_enemy = enemies_inRange[enemy_index]
	

func fire():
	readyToFire = false
	print("FIIIIIIIIIIIIIIIRE!!!!!!!!!!!")
	tageted_enemy.on_hit(damage)
	await(rateOfFire)
	readyToFire = true

func _on_fire_range_body_entered(enemy_area):
#	print(enemy_area)
	if enemy_area.is_in_group("enemies") :
		if isTouched:
			enemies_inRange.append(enemy_area.get_parent())
			print("enemies in sight: ")
			print(enemies_inRange)
	pass # Replace with function body.

func _on_fire_range_body_exited(enemy_node):
	if isTouched:
		enemies_inRange.erase(enemy_node.get_parent())
	pass # Replace with function body.


