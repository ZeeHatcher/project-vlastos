extends State
class_name RoamState


func enter(_msg: Dictionary = {}) -> void:
	owner.animated_sprite.playing = true
	owner.animated_sprite.speed_scale = 1
