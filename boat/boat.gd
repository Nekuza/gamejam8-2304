extends RigidBody2D

@export var start_health = 100
@export var start_position = Vector2(728,472)
var health

signal hit
signal destroyed

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("4")
	get_node("../Player/PlayerCamera/GameOver_Label").visible_characters = 0
	health = start_health
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# TODO: change sprite on health thresholds
	# 0, 25, 50, 75, 100 health left
	
	if health <= 0:
		change_state("0")
		
		destroyed.emit()
		get_node("../Player/PlayerCamera/GameOver_Label").visible_characters = -1
		$YouLoseSound.play()
		get_node("../Player/PlayerCamera/Score_Label").text = "Score: " + str(get_parent().score)
		
	elif health <= 25:
		change_state("1")
		
	elif health <= 50:
		change_state("2")
		
	elif health <= 75:
		change_state("3")
		
	pass
	
func change_state(number):
	$BreakSound.play
	get_node("../Player/PlayerCamera/AnimatedSprite2D").play(number)
	$AnimatedSprite2D.play(number)
	pass

func start(pos):
	position = start_position
	health = start_health
	show()
	$CollisionShape2D.disabled = false
	pass

func flicker_on_hit():
	var flicker_time = 50
	# TODO: for next flicker_time frames
	for flicker_count in flicker_time:
		visible = !visible
	visible = true
	pass

func _on_body_entered(body):
	# TODO if body == player:
	#	access hub
	# elif body == mob:
	health -= take_damage(1)
	flicker_on_hit()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

func take_damage(dmg):
	health -= dmg

func _on_CollisionShape2D_area_entered(area):
	if area.get_parent().is_in_group("Enemies"):
		hit.emit()
	elif area.get_parent().is_in_group("Player"):
		#TODO open Hub
		pass

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.


func _on_hit():
	take_damage(1)
	flicker_on_hit() # Player disappears after being hit.
	pass # Replace with function body.
