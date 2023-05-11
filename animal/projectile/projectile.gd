extends Area2D

var speed = 750
var eligible_targets = ["Mob1","Mob2","Mob3","Mob4","Mob5"]

func _physics_process(delta):
	position += transform.x * speed * delta


func _on_body_entered(body):
	pass;
	#if body.name in eligible_targets:
	#	body.queue_free()
	#queue_free()
