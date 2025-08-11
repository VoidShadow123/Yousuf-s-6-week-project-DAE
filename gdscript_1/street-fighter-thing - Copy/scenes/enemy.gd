extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0

var health = 100
var is_attacking = false
var can_move = true
var attack_timer = 0.0
var punch_duration = 0.5
var punch_lock_time = 0.2

func _ready():
	$Hitbox.connect("area_entered", Callable(self, "_on_hitbox_area_entered"))
	$Hitbox.monitoring = false  # disable until attack

func _physics_process(delta):
	if is_attacking:
		attack_timer -= delta
		if attack_timer <= 0:
			is_attacking = false
			can_move = true
			$Hitbox.monitoring = false  # stop detecting hits
		elif attack_timer <= punch_duration - punch_lock_time:
			can_move = true

	var direction = 0
	if can_move:
		direction = Input.get_axis("p2_left", "p2_right")
		velocity.x = direction * SPEED
	else:
		velocity.x = 0

	if Input.is_action_just_pressed("p2_jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("p2_attack") and not is_attacking:
		attack()

	if is_attacking:
		$Player2AnimatedSprite2D.play("Punch")
	elif direction != 0:
		$Player2AnimatedSprite2D.flip_h = direction < 0
		$Player2AnimatedSprite2D.play("Run")
	else:
		$Player2AnimatedSprite2D.play("Idle")

	velocity.y += 1200 * delta
	move_and_slide()

func attack():
	is_attacking = true
	can_move = false
	attack_timer = punch_duration
	$Hitbox.monitoring = true  # enable hit detection

func _on_hitbox_area_entered(area):
	if area and area.name == "Hurtbox":
		var enemy = area.get_parent()
		if enemy and enemy.has_method("take_damage"):
			enemy.take_damage(10)

func take_damage(amount):
	health -= amount
	print("Player2 Health:", health)
