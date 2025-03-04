extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const BULLET_SCENE = preload("res://bullet.tscn")
var is_jumping := false
var is_shooting := false


@onready var anim :=$animation as AnimatedSprite2D
@onready var bullet_position: Marker2D = $bullet_position

func shoot_bullet():
	var bullet_instance = BULLET_SCENE.instantiate()
	
	if sign(bullet_position.position.x) == 1:
		bullet_instance.set_direction(1)
	else:
		bullet_instance.set_direction(-1)
		
	add_child(bullet_instance)
	bullet_instance.global_position = bullet_position.global_position

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		is_jumping = true
	elif is_on_floor():
		is_jumping = false
		
	if Input.is_action_just_pressed("shoot"):
		is_shooting = true
		shoot_bullet()
	else:
		is_shooting = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if Input.is_action_pressed("ui_left"):
		if sign(bullet_position.position.x) == 1:
			bullet_position.position.x = -28
	
	if Input.is_action_pressed("ui_right"):
		if sign(bullet_position.position.x) == -1:
			bullet_position.position.x = 2
	
	if direction:
		velocity.x = direction * SPEED
		anim.scale.x = direction
		if !is_jumping:
			anim.play("run")
	elif is_jumping:
		anim.play("jump")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		anim.play("idle")

	move_and_slide()
