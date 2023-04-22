extends CharacterBody2D

var speed = 100  # speed in pixels/sec
var direction = 0


func get_input():
	velocity = Vector2.ZERO
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	
	get_input()
	move_and_slide()
	
func _process(delta):
	if velocity.y > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("back")
		$AnimatedSprite2D.flip_h = false
		
	elif velocity.y < 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play("front")
		$AnimatedSprite2D.flip_h = false
		
	elif velocity.x != 0:
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = velocity.x > 0
		$AnimatedSprite2D.flip_v = false
		
	else:
		$AnimatedSprite2D.stop()
