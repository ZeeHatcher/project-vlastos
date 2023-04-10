extends State
class_name HuntState


export(int) var sprint_scale := 1.5

onready var world = get_viewport().get_node("Main")
onready var hunt_timer = $HuntTimer



func enter(_msg: Dictionary = {}) -> void:
	owner.animated_sprite.playing = true
	owner.animated_sprite.speed_scale = 2
	owner.chill_timer.start()
	hunt_timer.start()


func physics_process(delta):
	var player = world.get_node("Player")
	var direction = owner.global_position.direction_to(player.global_position)
	
	owner.velocity = direction * min(owner.speed, player.speed) * sprint_scale
	owner.rotation = direction.angle()
	owner.navigation_agent.set_velocity(owner.velocity)
	
	owner.velocity = owner.move_and_slide(owner.velocity)


func _on_HuntTimer_timeout():
	owner._state_machine.transition_to("RoamState")
