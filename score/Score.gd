extends TextureProgressBar

# TODO: add functionality.
#		intended for health bar over boat


signal update_health(amount)
signal reset


#@export var value: float = 100.0


#func _ready() -> void:
#	connect("update_health", self, "_on_update_health")
#	connect("reset", self, "_on_reset")
#
#
#func _on_update_health(_value: float) -> void:
#	value = _value
#	var tween = create_tween()
#	tween.tween_property($OverBar, "value", value, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
#	tween.tween_property($UnderBar, "value", value, 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
#
#
#func _on_reset() -> void:
#	value = 100
#	$OverBar.value = value
#	$UnderBar.value = value

# Called when the node enters the scene tree for the first time.
func _ready():
#	$HealthBar.set_value(100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
