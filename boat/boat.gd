extends RigidBody2D

signal hit

# TODO
# stats
var health = 100
start_position = Vector2(500,1000) 

# Called when the node enters the scene tree for the first time.
func _ready():
	position = set_position(start_position)
	start_health = 100 # TODO make variable for difficulty settings
	
	# TODO: 
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func set_position(x,y):
	position = Vector2(x,y)

func start(pos):
	position = set_position(start_position)
	health = start_health
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body):
	health -= 1
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
