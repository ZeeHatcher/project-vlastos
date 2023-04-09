extends KinematicBody2D


export (int) var speed = 200

var _velocity = Vector2()

onready var _sprite = $AnimatedSprite


func _physics_process(delta):
	_get_input()
	_handle_animation()
	_face()
	_velocity = move_and_slide(_velocity)


func _get_input():
	_velocity = Vector2()
	if Input.is_action_pressed("right"):
		_velocity.x += 1
	if Input.is_action_pressed("left"):
		_velocity.x -= 1
	if Input.is_action_pressed("down"):
		_velocity.y += 1
	if Input.is_action_pressed("up"):
		_velocity.y -= 1
	_velocity = _velocity.normalized() * speed


func _handle_animation():
	var is_moving = _velocity != Vector2.ZERO
	_sprite.playing = is_moving


func _face():
	var mouse_position = get_viewport().get_mouse_position()
	var direction = global_position.direction_to(mouse_position)
	
	_sprite.rotation = direction.angle() + PI / 2
