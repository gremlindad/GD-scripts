extends Control

signal tile_id(value)


var tile_state_buttons = preload("res://Resources/tile_state_button_Group.tres")

var floor_button_group = preload("res://Resources/floor_art_button_group.tres")
var wall_button_group = preload("res://Resources/wall_art_button_group.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for button in tile_state_buttons.get_buttons():
		button.connect("pressed",self,"swap_button_state")
	
	for button in floor_button_group.get_buttons():
		button.connect("pressed",self,"get_tile_id",[floor_button_group])
		
	for button in wall_button_group.get_buttons():
		button.connect("pressed",self,"get_tile_id",[wall_button_group])
		
	get_node("VBoxContainer/HBoxContainer/floors").pressed = true
	

func swap_button_state():
	var pressed_button = tile_state_buttons.get_pressed_button()
	if pressed_button.is_in_group("FLOORSTATE"):
		TileState.state = TileState.TILE_STATES.FLOORSTATE
	if pressed_button.is_in_group("WALLSTATE"):
		TileState.state = TileState.TILE_STATES.WALLSTATE
		
func get_tile_id(button_group):
	emit_signal("tile_id",button_group.get_pressed_button().name)
	print(button_group.get_pressed_button().name)
