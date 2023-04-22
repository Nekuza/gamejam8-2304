extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$start_game_sound.play()
@export var mob_scene: PackedScene
var score


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

