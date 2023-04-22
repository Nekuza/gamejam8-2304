extends RigidBody2D

signal hit

# TODO
# stats
var health = 100
@export var start_position = Vector2(20,20)#Vector2(500,1000) 
@export var start_health = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	position = start_position
	health = start_health # TODO make variable for difficulty settings
	
	# TODO: 
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



#func set_position(x,y):
#	position = Vector2(x,y)
#	pass

func start(pos):
	position = start_position
	health = start_health
	show()
	$CollisionShape2D.disabled = false

func flicker_on_hit():
	var flicker_time = 50
	# TODO: for next flicker_time frames
	for flicker_count in flicker_time:
		visible = !visible
	visible = true
	# pass

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
