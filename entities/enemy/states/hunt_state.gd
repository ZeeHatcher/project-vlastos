extends State
class_name HuntState


export(int) var sprint_scale := 1.5

onready var world = get_viewport().get_node("Main")
onready var hunt_timer = $HuntTimer
onready var track_timer = $TrackTimer


func enter(_msg: Dictionary = {}) -> void:
	owner.animated_sprite.playing = true
	owner.animated_sprite.speed_scale = 2
	owner.chill_timer.start()
	hunt_timer.start()
	track_timer.start()
	var player = world.get_node("Player")
	owner.set_target_location(player.global_position)


func physics_process(delta):
	var direction = owner.global_position.direction_to(owner.navigation_agent.get_next_location())
	owner.velocity = direction * owner.speed
	owner.rotation = direction.angle()
	owner.navigation_agent.set_velocity(owner.velocity)
	
	owner.velocity = owner.move_and_slide(owner.velocity)


func _on_HuntTimer_timeout():
	owner._state_machine.transition_to("RoamState")


func exit():
	hunt_timer.stop()
	track_timer.stop()


func _on_TrackTimer_timeout():
	var player = world.get_node("Player")
	owner.set_target_location(player.global_position)
