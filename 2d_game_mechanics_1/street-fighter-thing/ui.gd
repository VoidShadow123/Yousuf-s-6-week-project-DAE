extends CanvasLayer

@onready var player1 = get_node("../Player")
@onready var player2 = get_node("../Enemy")
@onready var p1_fill = $P1_HealthBar/Fill
@onready var p2_fill = $P2_HealthBar/Fill

var p1_max_health
var p2_max_health

func _ready():
	p1_max_health = player1.max_health
	p2_max_health = player2.max_health

	# Connect signals if players emit health_changed
	player1.connect("health_changed", Callable(self, "_on_p1_health_changed"))
	player2.connect("health_changed", Callable(self, "_on_p2_health_changed"))

func _on_p1_health_changed(new_health):
	var ratio = clamp(new_health / p1_max_health, 0, 1)
	p1_fill.size.x = 400 * ratio  # Adjust 400 if you made a different width

func _on_p2_health_changed(new_health):
	var ratio = clamp(new_health / p2_max_health, 0, 1)
	p2_fill.size.x = 400 * ratio

var p1_hits := 0
var p2_hits := 0

func update_hit_count(player_number, hits):
	if player_number == 1:
		$P1HitCount.text = "P1 Hits: " + str(hits)
	elif player_number == 2:
		$P2HitCount.text = "P2 Hits: " + str(hits)

var hits_landed := 0

func _on_Hurtbox_area_entered(area):
	if area.name == "Hitbox":
		var attacker = area.get_parent()
		if attacker != self and attacker.has_method("get_damage"):

			# If this player is being hit, attacker landed a punch
			if attacker.name == "Player1":
				attacker.hits_landed += 1
				get_tree().root.get_node("Main").update_hit_count(1, attacker.hits_landed)
			elif attacker.name == "Player2":
				attacker.hits_landed += 1
				get_tree().root.get_node("Main").update_hit_count(2, attacker.hits_landed)
