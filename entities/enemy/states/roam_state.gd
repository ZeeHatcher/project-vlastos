extends State
class_name RoamState


onready var world = get_viewport().get_node("Main")


func enter(_msg: Dictionary = {}) -> void:
	owner.animated_sprite.playing = true
	owner.animated_sprite.speed_scale = 1
	owner.chill_timer.start()


func pick_random_location():
	var random_target = world.get_node("Map").get_random_tile_coord()
	owner.set_target_location(random_target)
	print(random_target)


func _on_ChillTimer_timeout():
	owner.animated_sprite.playing = true
	pick_random_location()


func physics_process(delta):
	for ray in owner._raycasts.get_children():
		if ray.is_colliding() and ray.get_collider() is Player:
			owner._state_machine.transition_to("HuntState")
	
	var direction = owner.global_position.direction_to(owner.navigation_agent.get_next_location())
	owner.velocity = direction * owner.speed
	owner.rotation = direction.angle()
	owner.navigation_agent.set_velocity(owner.velocity)
	
	if not _arrived_at_location():
		owner.velocity = owner.move_and_slide(owner.velocity)
		owner.animated_sprite.playing = true
	elif not owner.arrived:
		owner.arrived = true
		owner.chill_timer.start()
	else:
		owner.animated_sprite.playing = false


func _arrived_at_location() -> bool:
	return owner.navigation_agent.is_navigation_finished()
