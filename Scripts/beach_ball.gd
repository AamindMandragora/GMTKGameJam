extends CharacterBody2D

const BOUNCE_VELOCITY = -300.0

func _ready() -> void:
	# Seed random number generator
	randomize()

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Bounce with random strength when touching the floor
	if is_on_floor() and velocity.y >= 0:
		velocity.y = BOUNCE_VELOCITY

	# No horizontal movement
	velocity.x = 0

	move_and_slide()
