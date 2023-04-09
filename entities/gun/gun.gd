extends Node2D

signal shot

export(int) var bullets = 3

var _can_shoot = true

onready var _timer = $CooldownTimer


func shoot():
	if bullets > 0 and _can_shoot:
		bullets -= 1
		print("shoot")
		emit_signal("shot")
		_can_shoot = false
		_timer.start()


func _on_CooldownTimer_timeout():
	_can_shoot = true
