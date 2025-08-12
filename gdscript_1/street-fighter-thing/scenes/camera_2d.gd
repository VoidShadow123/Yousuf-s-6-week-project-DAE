extends Camera2D

@onready var player1 = get_node("../Player")
@onready var player2 = get_node("../Enemy")

func _process(_delta):
	var midpoint = (player1.global_position + player2.global_position) / 2
	global_position = global_position.lerp(midpoint, 0.1)

	var distance = abs(player1.global_position.x - player2.global_position.x)
	var target_zoom = clamp(400.0 / distance, 1.0, 2.0)
	zoom = zoom.lerp(Vector2(target_zoom, target_zoom), 0.5)
