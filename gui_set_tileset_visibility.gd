extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	TileState.connect("tile_state_change",self,"swap_tiles")
	
	
	
func swap_tiles():
	if TileState.state == TileState.TILE_STATES.FLOORSTATE:
		tile_set_swap("FLOORS SELECTION SCROLL")
		
	if TileState.state == TileState.TILE_STATES.WALLSTATE:
		tile_set_swap("WALLS SELECTION SCROLL")
		

func tile_set_swap(name_of_set):
	for ch in get_children():
			if ch.name != name_of_set:
				ch.visible = false
			else:
				ch.visible = true
