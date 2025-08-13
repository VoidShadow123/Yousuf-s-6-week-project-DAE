extends CharacterBody2D

@export var speed := 200
@export var jump_force := -500
@export var gravity := 800
@export var damage := 10
@export var max_health := 100

var health := max_health
var is_attacking := false
var punch_count := 0

@export var punch_label_path: NodePath   # assign to your “Player2Punches” Label

@onready var punch_timer: Timer = $PunchTimer

func _ready():
	# UI init
	if punch_label_path != NodePath(""):
		get_node(punch_label_path).text = "Player 2 Punches: 0"

	# Combat init
	$Hurtbox.monitoring = true
	$Hurtbox.connect("area_entered", _on_Hurtbox_area_entered)
	$Hitbox.monitoring = false  # only enabled during attack
	punch_timer.timeout.connect(_on_punch_timer_timeout)

func _physics_process(delta):
	# gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = min(velocity.y, 0)

	var input_x := 0.0
	if not is_attacking:
		input_x = Input.get_action_strength("p2_right") - Input.get_action_strength("p2_left")
		velocity.x = input_x * speed
		if Input.is_action_just_pressed("p2_jump") and is_on_floor():
			velocity.y = jump_force
	else:
		velocity.x = 0

	move_and_slide()

	# Attack
	if Input.is_action_just_pressed("p2_attack") and not is_attacking:
		start_attack()

	# Anim
	if is_attacking:
		$AnimatedSprite2D.play("Punch")
	elif input_x != 0:
		$AnimatedSprite2D.flip_h = input_x < 0
		$AnimatedSprite2D.play("Run")
	else:
		$AnimatedSprite2D.play("Idle")

func start_attack():
	is_attacking = true
	$Hitbox.monitoring = true
	punch_timer.start(0.5)

func _on_punch_timer_timeout():
	$Hitbox.monitoring = false
	is_attacking = false

func _on_Hurtbox_area_entered(area: Area2D):
	if not area or area.name != "Hitbox":
		return
	var attacker := area.get_parent()
	print("[P2 Hurtbox] entered by:", area.name, " attacker=", attacker.name)

	if attacker == self:
		return
	if attacker.has_method("get_damage"):
		take_damage(attacker.get_damage())
	# Credit the attacker for the hit
	if attacker.has_method("register_punch"):
		attacker.register_punch()

func register_punch():
	punch_count += 1
	if punch_label_path != NodePath(""):
		get_node(punch_label_path).text = "Player 2 Punches: " + str(punch_count)

func get_damage() -> int:
	return damage

func take_damage(amount: int):
	health -= amount
	print("Player 2 HP:", health)
	if health <= 0:
		queue_free()


func _on_hurtbox_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
