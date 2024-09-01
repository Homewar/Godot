extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D
@onready var weapon = $Weapon
@onready var collision = $CollisionShape2D


const speed = 100  #стандартная скорость
const dash_speed = 400  # скорость рывка
const dash_duration = 0.1  # Длительность рывка
var is_dashing = false
var dash_timer = 0.0
var dash_direction = Vector2.ZERO

func get_input(delta):
	if not is_dashing:
		var input_direction = Input.get_vector("left", "right", "up", "down")
		velocity = input_direction * speed
		
		if Input.is_action_just_pressed("jump") and input_direction != Vector2.ZERO:
			is_dashing = true
			dash_timer = dash_duration
			dash_direction = input_direction
			set_collision_mask_value(2,false)
	else:
		velocity = dash_direction * dash_speed

func _process(delta):
	Global.player_pos = position
	weapon.rotation_degrees = Global.x_axis_angle(Global.player_pos, get_global_mouse_position())
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0.0:
			is_dashing = false
			set_collision_mask_value(2,true)
	
	get_input(delta)
	animation()
	move_and_slide()

func animation():
	if Input.is_action_pressed("down"):
		_animated_sprite.play("down")
	elif Input.is_action_pressed("up"):
		_animated_sprite.play("up")
	elif Input.is_action_pressed("left"): 
		_animated_sprite.scale.x = -1.5
		_animated_sprite.play("left")
	elif Input.is_action_pressed("right"):
		_animated_sprite.play("right")
	else:
		_animated_sprite.scale.x = 1.5
		_animated_sprite.stop()
