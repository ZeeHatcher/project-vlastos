extends KinematicBody2D
class_name Enemy


export(int) var _speed := 200
export(int) var _hunt_time := 10.0
export(int) var _detection_range := 200.0
export(int) var _angle_cone_of_vision := deg2rad(30.0)
export(int) var _angle_between_rays := deg2rad(5.0)

var direction := Vector2()
var velocity := Vector2()
var target_location := Vector2(1000,-700)
var arrived := false

onready var _state_machine := $StateMachine
onready var animated_sprite := $AnimatedSprite
onready var _collision_shape := $CollisionShape2D
onready var _raycasts := $Raycasts
onready var _navigation_agent := $NavigationAgent2D


func _ready():
	_generate_raycasts()
	_state_machine.transition_to("RoamState")


func die() -> void:
	_state_machine.transition_to("DeathState")


func _generate_raycasts() -> void:
	var ray_count := _angle_cone_of_vision / _angle_between_rays
	
	for index in ray_count:
		var ray := RayCast2D.new()
		var angle = _angle_between_rays * (index - ray_count / 2.0)
		ray.cast_to = Vector2.UP.rotated(angle) * _detection_range
		_raycasts.add_child(ray)
		ray.enabled = true


func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("down"):
		set_target_location(target_location)
	
	for ray in _raycasts.get_children():
		if ray.is_colliding() and ray.get_collider() is Player:
			_state_machine.transition_to("HuntState")
	
	var direction = global_position.direction_to(_navigation_agent.get_next_location())
	velocity = direction * _speed
	rotation = direction.angle()
	_navigation_agent.set_velocity(velocity)
	
	if not _arrived_at_location():
		velocity = move_and_slide(velocity)
	elif not arrived:
		arrived = true


func _arrived_at_location() -> bool:
	return _navigation_agent.is_navigation_finished()


func set_target_location(target) -> void:
	arrived = false
	target_location = target
	_navigation_agent.set_target_location(target)
