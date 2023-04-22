extends CharacterBody2D

@export_category("Select animal")
@export_enum("boris", "cow", "eagle", "goat", "pig", "wolf") 
var animal_type: String = "eagle"


func _process(delta):
	$AnimatedSprite2D.play(animal_type)
