extends CharacterBody2D

const SPEED = 140.0
const JUMP_VELOCITY = -300.0
const DOUBLE_JUMP_VELOCITY = -200.0
const COYOTE_TIME = 0.15
const MAX_JUMPS = 2

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var dead = false
var coyote_timer = 0.0
var jumps_left = MAX_JUMPS


func _physics_process(delta: float) -> void:
	if dead:
		return

	# Coyote time
	if is_on_floor():
		coyote_timer = COYOTE_TIME
		jumps_left = MAX_JUMPS
	else:
		coyote_timer -= delta

	# Add gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump"):
		# First jump / coyote jump
		if coyote_timer > 0:
			velocity.y = JUMP_VELOCITY
			coyote_timer = 0
			jumps_left -= 1

		# Second jump
		elif jumps_left > 0:
			velocity.y = DOUBLE_JUMP_VELOCITY
			jumps_left -= 1

	# Get input direction
	var direction := Input.get_axis("move_left", "move_right")

	# Flip sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true

	# Play animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("default")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")

	# Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func die() -> void:
	if dead:
		return

	dead = true
	velocity = Vector2.ZERO

	animated_sprite.play("death")

	await animated_sprite.animation_finished

	queue_free()
