extends KinematicBody2D
class_name Player


signal dead

export(int) var speed = 200
export(float) var slowness_multiplier = 0.5

var _velocity = Vector2()
var _facing = Vector2.UP

onready var _sprite = $AnimatedSprite
onready var _gun = $Gun


func _physics_process(delta):
	_get_input()
	_face()
	_handle_movement()
	_handle_animation()


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


func _unhandled_input(event):
	if event.is_action_pressed("shoot"):
		_gun.shoot()


func die():
	emit_signal("dead")


func _handle_animation():
	var is_moving = _velocity != Vector2.ZERO
	_sprite.playing = is_moving


func _handle_movement():
	var dot = _velocity.normalized().dot(_facing)
	var facing_forwards = dot > 0
	
	var sp = speed if facing_forwards else speed * slowness_multiplier
	
	_sprite.speed_scale = 1 if facing_forwards else slowness_multiplier
	
	_velocity = _velocity.normalized() * sp
	_velocity = move_and_slide(_velocity)


func _face():
	var mouse_position = get_global_mouse_position()
	var direction = global_position.direction_to(mouse_position)
	
	rotation = direction.angle()
	_facing = direction
