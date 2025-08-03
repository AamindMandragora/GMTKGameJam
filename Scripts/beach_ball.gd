extends CharacterBody2D

const BOUNCE_VELOCITY = -300.0
const RISE_VELOCITY = -100.0  # upward velocity when in water

var start_position: Vector2

func _ready() -> void:
	start_position = position

func reset_to_start():
	position = start_position
	velocity = Vector2.ZERO

func _physics_process(delta: float) -> void:
	# Apply gravity if not in water mode
	if not Globals.is_water_mode and not is_on_floor():
		velocity += get_gravity() * delta

	# Behavior when in water mode: rise to top
	if Globals.is_water_mode:
		velocity.y = RISE_VELOCITY
	else:
		# Normal bounce behavior
		if is_on_floor() and velocity.y >= 0:
			velocity.y = BOUNCE_VELOCITY

	# No horizontal movement
	velocity.x = 0

	move_and_slide()
