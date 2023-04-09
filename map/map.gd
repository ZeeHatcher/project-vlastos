extends TileMap


func get_random_tile_coord():
	randomize()
	var cells = get_used_cells_by_id(2)
	var cell = cells[int(rand_range(0, cells.size()))]
	var coord = map_to_world(cell)
	return coord
