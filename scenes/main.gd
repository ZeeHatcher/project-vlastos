extends Node2D


const KeyScene = preload("res://entities/key/key.tscn")

export(int) var keys_count = 3

var _keys_collected = 0

onready var _help_text = $CanvasLayer/UI/HelpText


func _ready():
	randomize()
	_spawn_keys()


func _spawn_keys():
	var locations = _shuffle($KeyLocations.get_children())
	
	for n in range(keys_count):
		var location = locations.pop_back()
		
		if not location:
			break
		
		var key = KeyScene.instance()
		key.global_position = location.global_position
		key.connect("collected", self, "_on_Key_collected")
		add_child(key)


func _shuffle(list):
	var shuffled = [] 
	var indices = range(list.size())
	for i in range(list.size()):
		var x = randi() % indices.size()
		shuffled.append(list[indices[x]])
		indices.remove(x)
	return shuffled


func _win():
	print("win")


func _on_Key_collected():
	_keys_collected += 1
	
	var text = ""
	if _keys_collected == keys_count:
		text = "You have found all the keys!\nFind the exit and escape!"
	else:
		text = "Key found.\n%d out of %d keys found." % [_keys_collected, keys_count]
		
	_help_text.show_text(text)


func _on_Exit_body_entered(body):
	if _keys_collected == keys_count:
		_win()
	else:
		_help_text.show_text("You need to find all the keys to escape.\n%d out of %d keys found." % [_keys_collected, keys_count])
