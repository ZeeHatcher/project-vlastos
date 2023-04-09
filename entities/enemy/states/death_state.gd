extends State
class_name DeathState


func enter(_msg: Dictionary = {}) -> void:
	owner.animated_sprite.playing = false
	owner.queue_free()
