extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -480.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("p2_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("p2_left", "p2_right")
	
	#flip the sprite
	if direction > 0:
		$Player2AnimatedSprite2D.flip_h = false
	elif direction < 0:
		$Player2AnimatedSprite2D.flip_h = true
	
	#Play animations
	if direction == 0:
		$Player2AnimatedSprite2D.play("Idle")
	else:
		$Player2AnimatedSprite2D.play("Run")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
var health = 100

func take_damage(amount):
	health -= amount
	if health <= 0:
		print("KO")
		queue_free()
func _ready():
	take_damage(10)  # This will work and call your function at start
