extends KinematicBody2D


export(int) var _speed
export(int) var _hunt_time
export(int) var _detection_range

var direction := Vector2()
var velocity := Vector2()

onready var _state_machine := $StateMachine
onready var animated_sprite := $AnimatedSprite
onready var collision_shape := $CollisionShape2D


func _ready():
	_state_machine.transition_to("RoamState")
	

func die() -> void:
	_state_machine.transition_to("DeathState")
