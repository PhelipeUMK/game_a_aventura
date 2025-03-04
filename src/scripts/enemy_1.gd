extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -400.0

@onready var detector := $detector as RayCast2D
@onready var texture := $texture as Sprite2D

var direction := -1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if detector.is_colliding():
		direction *= -1
		detector.scale.x *= -1
	velocity.x = direction * SPEED * delta
	
	if direction == 1:
		texture.flip_h = false
	else:
		texture.flip_h = true

	move_and_slide()
