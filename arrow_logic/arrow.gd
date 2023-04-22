extends Node2D

# Zielposition, auf die der Pfeil zeigen soll
var target_position: Vector2

# Pfeil-Sprite
var arrow_sprite: Sprite2D

# Pfeil-Overlay-Node
var arrow_overlay: Node2D

func _ready():
	# Erstelle das Pfeil-Sprite und füge es dem Pfeil-Overlay hinzu
	arrow_sprite = Sprite2D.new()
	arrow_sprite.texture = preload("res://assets/arrow/arrow.png")
	arrow_overlay = Node2D.new()
	arrow_overlay.add_child(arrow_sprite)
	add_child(arrow_overlay)

func _process(delta):
	# Bestimme die Position des Zielobjekts relativ zur Kamera
	var camera_position = get_viewport().get_camera().global_transform.origin
	var target_relative_position = target_position - camera_position
	
	# Berechne den Winkel zwischen der Kamera und dem Zielobjekt
	var angle = atan2(target_relative_position.y, target_relative_position.x)
	
	# Setze die Rotation des Pfeil-Sprites entsprechend des Winkels
	arrow_sprite.rotation = angle
	
	# Bestimme die Größe des Pfeil-Overlays basierend auf der Entfernung zum Zielobjekt
	var distance = target_relative_position.length()
	arrow_overlay.scale = Vector2(distance, distance) / 100
	
	# Platziere das Pfeil-Overlay auf dem Bildschirm
	var screen_size = get_viewport_rect().size
	arrow_overlay.position = screen_size / 2
