extends Node2D

signal shot

export(int) var bullets = 3

var _can_shoot = true

onready var _timer = $CooldownTimer
onready var _ray = $RayCast2D


onready var world = get_viewport().get_node("Main")


func _ready():
	connect("shot", world, "_on_Gun_shot")


func shoot():
	if bullets > 0 and _can_shoot:
		print("shoot")
		
		var collider = _ray.get_collider()
		if collider and collider.has_method("die"):
			collider.die()
		
		emit_signal("shot")
		bullets -= 1
		_can_shoot = false
		_timer.start()


func _on_CooldownTimer_timeout():
	_can_shoot = true
