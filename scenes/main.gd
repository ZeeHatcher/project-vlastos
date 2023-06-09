extends Node2D


const KeyScene = preload("res://entities/key/key.tscn")

export(int) var keys_count = 3

var _keys_collected = 0
var aggression_level = 0

var AGGRESSION_STATS = {
	0: {"range": 200, "speed": 100},
	1: {"range": 350, "speed": 200},
	2: {"range": 550, "speed": 300},
	3: {"range": 999, "speed": 400},
}

onready var _help_text = $CanvasLayer/UI/HelpText
onready var _eyes = $CanvasLayer/UI/Eyes


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
	_show_game_over("You Escaped!")


func _lose():
	_show_game_over("You Died!")


func _show_game_over(text):
	var scene = load("res://ui/game_over/game_over.tscn")
	var instance = scene.instance()
	instance.set_title(text)
	$CanvasLayer.add_child(instance)


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


func _on_Player_dead():
	_lose()


func _on_Gun_shot():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for e in enemies:
		e.hear_gunshot()
		
	increase_awareness()
	_eyes.increase()


func increase_awareness():
	aggression_level += 1
	aggression_level = min(aggression_level, 3)
	
	var enemies = get_tree().get_nodes_in_group("Enemy")
	for enemy in enemies:
		enemy.speed = AGGRESSION_STATS[aggression_level]["speed"]
		enemy.detection_range = AGGRESSION_STATS[aggression_level]["range"]
