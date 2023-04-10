extends KinematicBody2D
class_name Enemy

var direction := Vector2()
var velocity := Vector2()
var target_location := Vector2(1000,-700)
var arrived := false

export(int) var speed := 200
export(int) var _hunt_time := 10
export(int) var detection_range := 200
export(int) var _angle_cone_of_vision := deg2rad(90.0)
export(int) var _angle_between_rays := deg2rad(15.0)

onready var animated_sprite := $AnimatedSprite
onready var chill_timer := $ChillTimer

onready var _state_machine := $StateMachine
onready var _collision_shape := $CollisionShape2D
onready var _raycasts := $Raycasts
onready var navigation_agent := $NavigationAgent2D


func _ready():
	_generate_raycasts()
	_state_machine.transition_to("RoamState")


func die() -> void:
	_state_machine.transition_to("DeathState")


func _generate_raycasts() -> void:
	var ray_count := _angle_cone_of_vision / _angle_between_rays
	
	for index in ray_count:
		var ray := RayCast2D.new()
		var angle = _angle_between_rays * (index - ray_count / 2.0) + deg2rad(90.0)
		ray.cast_to = Vector2.UP.rotated(angle) * detection_range
		_raycasts.add_child(ray)
		ray.enabled = true


func _physics_process(delta) -> void:
	for ray in _raycasts.get_children():
		if ray.is_colliding() and ray.get_collider() is Player:
			_state_machine.transition_to("HuntState")
	
	_state_machine.state.physics_process(delta)


func set_target_location(target) -> void:
	arrived = false
	target_location = target
	navigation_agent.set_target_location(target)


func hear_gunshot():
	_state_machine.transition_to("HuntState")
