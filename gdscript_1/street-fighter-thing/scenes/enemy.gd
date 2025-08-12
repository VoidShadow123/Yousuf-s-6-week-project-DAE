extends CharacterBody2D

@export var speed := 200
@export var jump_force := -550
@export var gravity := 800
@export var damage := 10
@export var max_health := 100

var health := max_health
var is_attacking := false

func _ready():
	# Only connect the Hitbox signal, as it's the one responsible for dealing damage.
	$Hitbox.connect("area_entered", self._on_Hitbox_area_entered)
	$Hitbox.monitoring = false

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = min(velocity.y, 0)

	var input_vector = Vector2.ZERO

	if not is_attacking:
		input_vector.x = Input.get_action_strength("p2_right") - Input.get_action_strength("p2_left")
		velocity.x = input_vector.x * speed

		if Input.is_action_just_pressed("p2_jump") and is_on_floor():
			velocity.y = jump_force
	else:
		velocity.x = 0

	move_and_slide()

	# Attack input
	if Input.is_action_just_pressed("p2_attack") and not is_attacking:
		start_attack()

	# --- Animation handling ---
	if is_attacking:
		$AnimatedSprite2D.play("Punch")
	else:
		if input_vector.x != 0:
			$AnimatedSprite2D.flip_h = input_vector.x < 0
			$AnimatedSprite2D.play("Run")
		else:
			$AnimatedSprite2D.play("Idle")

func start_attack():
	is_attacking = true
	$AnimatedSprite2D.play("Punch")
	$Hitbox.monitoring = true
	$Timer.start(0.5)  # Attack lasts 0.5s
	await $Timer.timeout
	$Hitbox.monitoring = false
	is_attacking = false

# This function is called when a hitbox collides with another Area2D.
func _on_Hitbox_area_entered(area):
	# Check if the colliding area is a Hurtbox
	if area.name == "Hurtbox":
		# Get the character script that owns the Hurtbox
		var target = area.get_parent()
		# Make sure the target is not this character and has a take_damage method
		if target != self and target.has_method("take_damage"):
			target.take_damage(damage)

# Removed the _on_Hurtbox_area_entered function completely.
# The Hitbox's signal is now solely responsible for applying damage.

func take_damage(damage, health):
	health -= damage
	print(name, " took ", damage, " damage! HP: ", health)
	if health <= 0:
		print(name, " is defeated!")
		# Add defeat logic here (e.g., play a death animation, signal game over, etc.)
func start_hitbox():
	$Hitbox.monitoring = true
	print("Hitbox Activated!")

func end_hitbox():
	$Hitbox.monitoring = false
	print("Hitbox Deactivated!")
	is_attacking = false
