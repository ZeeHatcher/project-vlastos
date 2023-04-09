extends MarginContainer


onready var _label = $Label
onready var _animation_player = $AnimationPlayer


func show_text(text):
	_label.text = text
	_animation_player.play("fade")
