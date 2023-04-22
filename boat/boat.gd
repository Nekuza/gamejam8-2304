extends RigidBody2D

var start_health = 100
var health
signal hit

# TODO
# stats

# Called when the node enters the scene tree for the first time.
func _ready():
	health = start_health
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	health -= 1
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
