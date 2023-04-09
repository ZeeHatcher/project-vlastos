extends CenterContainer


var _can_handle_input = false


func _ready():
	get_tree().paused = true
	$AnimationPlayer.play("fade")


func _input(event):
	if not _can_handle_input:
		return
	
	var is_button = event is InputEventKey or event is InputEventMouseButton
	
	if is_button and event.pressed:
		var tree = get_tree()
		tree.change_scene("res://scenes/main.tscn")
		tree.set_input_as_handled()
		tree.paused = false


func set_title(val):
	$VBoxContainer/MarginContainer/Title.text = val


func _on_AnimationPlayer_animation_finished(anim_name):
	_can_handle_input = true
