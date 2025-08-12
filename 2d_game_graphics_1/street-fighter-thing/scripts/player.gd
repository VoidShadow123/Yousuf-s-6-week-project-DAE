extends CharacterBody2D

@export var speed := 200
@export var jump_force := -550
@export var gravity := 800
@export var damage := 10
@export var max_health := 100

var health := max_health
var is_attacking := false

func _ready():
	# Connect the hurtbox signal to this script
	$Hurtbox.connect("area_entered", self._on_Hurtbox_area_entered)
	$Hitbox.monitoring = false

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = min(velocity.y, 0)

	var input_vector = Vector2.ZERO

	if not is_attacking:
		input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		velocity.x = input_vector.x * speed

		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_force
	else:
		velocity.x = 0

	move_and_slide()

	# Attack input
	if Input.is_action_just_pressed("attack") and not is_attacking:
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

# This function is called when a hitbox enters this character's hurtbox.
func _on_Hurtbox_area_entered(area):
	# Check if the colliding area is a hitbox
	if area.name == "Hitbox":
		var attacker = area.get_parent()
		# Make sure the attacker isn't this character and has a damage-providing function
		if attacker != self and attacker.has_method("get_damage"):
			take_damage(attacker.get_damage())

# This function provides the damage value for an external object to read.
func get_damage():
	return damage

func take_damage(damage):
	health -= damage
	print(name, " took ", damage, " damage! HP: ", health)
	if health <= 0:
		print(name, " is defeated!")
		# You can add logic here for what happens when the player is defeated (e.g., game over, restart, etc.)
func start_hitbox():
	$Hitbox.monitoring = true
	print("Hitbox Activated!")

func end_hitbox():
	$Hitbox.monitoring = false
	print("Hitbox Deactivated!")
	is_attacking = false
