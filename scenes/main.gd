extends Node2D


const KeyScene = preload("res://entities/key/key.tscn")

export(int) var keys_count = 3

var _keys_collected = 0


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


func _on_Key_collected():
	print("collected")
	_keys_collected += 1


func _shuffle(list):
	var shuffled = [] 
	var indices = range(list.size())
	for i in range(list.size()):
		var x = randi() % indices.size()
		shuffled.append(list[indices[x]])
		indices.remove(x)
	return shuffled
