extends Node2D

signal shot

export(int) var bullets = 3


func shoot():
	if bullets > 0:
		bullets -= 1
		print("shoot")
		emit_signal("shot")
