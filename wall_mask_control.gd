extends Light2D


func _ready():
	var fix = TileState.connect("tile_state_change",self,"disable")
	
func disable():
	if TileState.state == TileState.TILE_STATES.WALLSTATE:
		enabled = false
	else:
		enabled = true
