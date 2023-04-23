extends Control

@onready var ResOptButton = $VBoxContainer/HBoxContainer/OptionButton

var Resolution: Dictionary = {
	"1920x1080": Vector2(1920, 1080),
	"1280x720": Vector2(1280, 720),
	"1024x600": Vector2(1024, 600),
	"800x600": Vector2(800, 600)
}

func _ready():
	AddResToButton()
	
func AddResToButton():
	for r in Resolution:
		ResOptButton.add_item(r)


func _on_option_button_item_selected(index):
	var size = Resolution.get(ResOptButton.get_item_text(index))
	DisplayServer.window_set_size(Vector2i(size))


func _on_back_pressed():
	get_tree().change_scene_to_file("res://UI/title_screen/tilte-ui.tscn")
