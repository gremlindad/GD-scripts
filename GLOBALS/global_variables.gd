extends Node


const TILE_WIDTH = 200
const TILE_HEIGHT = 100
const HALF_TILE_WIDTH = TILE_WIDTH/2
const HALF_TILE_HEIGHT = TILE_HEIGHT/2

const RHOMBUS_SLANT_RAD = asin(1/sqrt(5))
const RHOMBUS_SLANT_DEG = rad2deg(asin(1/sqrt(5)))

var cursor_position




var global_rotation_state = 0 setget set_global_rot

var local_rotation_state

func set_global_rot(value):
	if value >3:
		value = 0
	global_rotation_state = value
	
