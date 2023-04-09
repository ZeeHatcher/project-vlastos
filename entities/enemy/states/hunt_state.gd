extends State
class_name HuntState


func enter(_msg: Dictionary = {}) -> void:
	owner.animated_sprite.playing = true
	owner.animated_sprite.speed_scale = 2
	owner.chill_timer.start()
