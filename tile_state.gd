extends Node


signal tile_state_change

#FLOORSTATE,WALLSTATE,ITEMSTATE,

enum TILE_STATES {
	FLOORSTATE = 0,
	WALLSTATE,
	DOORSTATE,
	STAIRSTATE,
	ITEMSTATE,
	DECORSTATE,
	ENEMYSTATE,
	PLAYERSTATE
	}

var state setget set_tile_state

func set_tile_state(value):
	state = value
	emit_signal("tile_state_change")
