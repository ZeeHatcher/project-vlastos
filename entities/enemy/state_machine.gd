extends Node
class_name StateMachine


signal transitioned(state)

export(NodePath) var initial_state

var state: State


func _ready() -> void:
	yield(owner, "ready")
	
	for s in get_children():
		s.transition_to = funcref(self, "transition_to")

	var state_ = get_node(initial_state) if initial_state else get_child(0)
	
	assert(state_, "'%s' class does not have any state." % owner.name)
	
	transition_to(state_.name)


func process(delta: float) -> void:
	state.process(delta)


func physics_process(delta: float) -> void:
	state.physics_process(delta)


func unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_name):
		return

	if state:
		state.exit()

	state = get_node(target_state_name)
	state.enter(msg)
	
	emit_signal("transitioned", state.name)
