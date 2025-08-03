extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -400.0
const MIN_JUMP_VELOCITY = JUMP_VELOCITY

const COYOTE_TIME = 0.1
var coyote_timer = 0.0

const JUMP_BUFFER_TIME = 0.25
var jump_buffer_timer = 0.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

		# Decrease coyote timer
		if coyote_timer > 0:
			coyote_timer -= delta
	else:
		# Reset coyote timer when on ground
		coyote_timer = COYOTE_TIME

	# Decrease jump buffer timer
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

	# Register jump input (buffered)
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = JUMP_BUFFER_TIME

	# Attempt jump if within both jump buffer and coyote time
	if jump_buffer_timer > 0 and coyote_timer > 0:
		velocity.y = JUMP_VELOCITY
		jump_buffer_timer = 0
		coyote_timer = 0

	# Get movement input
	var direction := Input.get_axis("move left", "move right")

	# Flip sprite
	if direction == 1:
		animated_sprite.flip_h = false
	elif direction == -1:
		animated_sprite.flip_h = true

	# Play animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# Vertical movement
	velocity.y = max(velocity.y, MIN_JUMP_VELOCITY)

	move_and_slide()
