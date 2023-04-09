extends MarginContainer


const TILE_SIZE = 128
const MAX_TILES = 4

var _index = 0

onready var _atlas = $CenterContainer/TextureRect.texture


func increase():
	_index += 1
	
	if _index >= MAX_TILES:
		return
	
	var region = _atlas.region
	var position = Vector2(_index * TILE_SIZE, 0)
	_atlas.region = Rect2(position, region.size)
