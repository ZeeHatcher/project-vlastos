extends Node2D

signal shot


func shoot():
	print("shoot")
	emit_signal("shot")
