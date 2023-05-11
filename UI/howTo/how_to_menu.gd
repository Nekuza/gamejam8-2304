extends Node2D

@onready var _pm = $PopupMenu

var _mouse_pos

func _ready():
	_pm.add_item("How To Play")

func _input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_RIGHT:
		_mouse_pos = get_global_mouse_position()
		_pm.popup(Rect2(_mouse_pos.x, _mouse_pos.y, 50 ,50))


func _on_popup_menu_id_pressed(id):
	pass # Replace with function body.


func _on_popup_menu_index_pressed(index):
	pass # Replace with function body.
