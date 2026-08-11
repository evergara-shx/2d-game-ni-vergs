extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var dead = false

func _physics_process(delta: float) -> void:
	if dead:
		return

	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction
	var direction := Input.get_axis("move_left", "move_right")

	# Flips the sprite
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

	# Applies the movement
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
