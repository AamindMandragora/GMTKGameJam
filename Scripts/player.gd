extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -345.0
const MIN_JUMP_VELOCITY = JUMP_VELOCITY
const WATER_JUMP_MULTIPLIER = 1.25
const WATER_MOVEMENT_MULTIPLIER = 0.9

const COYOTE_TIME = 0.1
var coyote_timer = 0.0

const JUMP_BUFFER_TIME = 0.25
var jump_buffer_timer = 0.0

var jump_multiplier = 1
var movement_multiplier = 1

var start_position: Vector2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	start_position = position

func reset_to_start():
	position = start_position
	velocity = Vector2.ZERO
	get_node("CollisionShape2D").disabled = false

func _physics_process(delta: float) -> void:
	
	# Modify water physics
	if Globals.is_water_mode:
		jump_multiplier = WATER_JUMP_MULTIPLIER
		movement_multiplier = WATER_MOVEMENT_MULTIPLIER
	else:
		jump_multiplier = 1
		movement_multiplier = 1
	
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
		velocity.y = JUMP_VELOCITY * jump_multiplier
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
		velocity.x = direction * SPEED * movement_multiplier
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED) * movement_multiplier
		
	# Vertical movement limiter
	velocity.y = max(velocity.y, MIN_JUMP_VELOCITY * jump_multiplier)

	move_and_slide()
