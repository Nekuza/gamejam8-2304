extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$"VBoxContainer/start-button".grab_focus()
	$startup_sound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_startbutton_pressed():
	get_tree().change_scene_to_file("res://main_game.tscn")


func _on_optionsbutton_pressed():
	get_tree().change_scene_to_file("res://UI/options/ui_option_menu.tscn")
	$select_sound.play()
	# options-menu not yet implemented
	# var options = load("res://menus/options.tscn").instance()
	# get_tree().current_scene.add_child(options)


func _on_quitbutton_pressed():
	$select_sound.play()
	get_tree().quit()


func _on_about_pressed():
	pass # Replace with function body.
