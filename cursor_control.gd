extends Node2D

signal place_tile(tile_id,rot_count)
signal remove_tile


var tile_to_place = null #we send this to the tile master to use as a placement
var tile_instance = null


var tile_size_x = 200
var tile_size_y = 100

onready var cursor = $Cursor


var rotation_count = 0 


var is_left_clicking = false
var is_right_clicking = false
var has_moved_sub_snap = false
var just_rotated = false


func _ready():
	cursor.get_node("TileType").texture = null
	position = Vector2(get_global_mouse_position().x/tile_size_x,get_global_mouse_position().y/tile_size_y)



func _physics_process(_delta):
	
	primary_snapping_movement()
	
	#regular brush mode
	put_down_tiles()
	remove_tiles()
	
	
func _unhandled_input(_event):
	
	rotate_cursor()
	lazy_left_click_check()
	lazy_right_click_check()
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	




	
func _on_ui_update_tile_id(value):
	set_cursor_image(value)









####################################################
#movement
#####################################################

func primary_snapping_movement():
	var mouse_po = get_global_mouse_position()
	
	var snap_position = Vector2(mouse_po.x/200,mouse_po.y/100)
	var snap_x = round(snap_position.x)
	var snap_y
	if snap_position.y>=0:
		snap_y = int(snap_position.y)
	else:
		snap_y = int(snap_position.y-1)
	

	var not_updated_movement = position
	
	
	position.x = snap_x*200
	position.y = snap_y*100
#	

	var updated_movement = position 
	
	if updated_movement.x != not_updated_movement.x:
		cursor.position.x = cursor.position.x*-1	
	if updated_movement.y != not_updated_movement.y:
		cursor.position.y =cursor.position.y*-1


func _on_Top_left_mouse_entered():
	var position_before = cursor.position
	cursor.position = Vector2(-100,-50)
	var position_after = cursor.position
	if position_before != position_after:
		has_moved_sub_snap = true
func _on_Top_right_mouse_entered():
	var position_before = cursor.position
	cursor.position = Vector2(100,-50)
	var position_after = cursor.position
	if position_before != position_after:
		has_moved_sub_snap = true
func _on_Bottom_left_mouse_entered():
	var position_before = cursor.position
	cursor.position = Vector2(-100,50)
	var position_after = cursor.position
	if position_before != position_after:
		has_moved_sub_snap = true
func _on_Bottom_right_mouse_entered():
	var position_before = cursor.position
	cursor.position = Vector2(100,50)
	var position_after = cursor.position
	if position_before != position_after:
		has_moved_sub_snap = true	
func _on_centre_mouse_entered():
	var position_before = cursor.position
	cursor.position = Vector2.ZERO
	var position_after = cursor.position
	if position_before != position_after:
		has_moved_sub_snap = true

























#when tilestate changes update cursor image
func set_cursor_image(value):
	
	var dic_keys = TileLibrary.asset_dictionary.keys()
	
	for key in dic_keys:
		if key == value:
			tile_to_place = TileLibrary.asset_dictionary[key]
			
			#this is the parent tile
			tile_instance = tile_to_place.instance()
			tile_instance.tile_rotation_state = rotation_count
			var tile_sprite = tile_instance.get_child(tile_instance.get_child_count()-1).get_node("Sprite")
			$Cursor/TileType.texture = tile_sprite.texture
			$Cursor/TileType.offset = tile_sprite.offset
	


	
	
	
	

	
	
	
	
func rotate_cursor():
	if Input.is_action_just_pressed("Rotate"):
		
		#needs to just update texture on floor tile
		#needs to swap between rotation 0 and 3 for walls
		
		
		refresh_tile_texture()
		rotation_count += 1
		if rotation_count == 4:
			rotation_count = 0
			
			
		if tile_instance !=null:
			
			refresh_tile_texture()
		
		
	if Input.is_action_just_released("Rotate"):
		just_rotated = true
			
			
			
			
func refresh_tile_texture():
	
	#we made an instance but why is this affecting all instances
	
	tile_instance.tile_rotation_state = rotation_count
	var tile_sprite = tile_instance.get_child(tile_instance.get_child_count()-1).get_node("Sprite")
	$Cursor/TileType.texture = tile_sprite.texture
	$Cursor/TileType.offset = tile_sprite.offset
	







			
			
func put_down_tiles():
	#if has_moved_sub_snap and is_left_clicking and tile_to_place!=null:
	if is_left_clicking and tile_to_place!=null:
		emit_signal("place_tile",tile_to_place,rotation_count)
		has_moved_sub_snap = false
		
##	elif just_rotated and has_moved_sub_snap == false and is_left_clicking and tile_to_place!=null:
#	elif is_left_clicking and tile_to_place!=null:
#		just_rotated = false
#		emit_signal("place_tile",tile_to_place,rotation_count)
		
func remove_tiles():
	if has_moved_sub_snap and is_right_clicking and tile_to_place !=null:
		emit_signal("remove_tile")










		
func lazy_left_click_check():
	if Input.is_action_just_pressed("LMC"):
		is_left_clicking = true
	if Input.is_action_just_released("LMC"):
		is_left_clicking = false
	
func lazy_right_click_check():
	if Input.is_action_just_pressed("RMC"):
		is_right_clicking = true
	if Input.is_action_just_released("RMC"):
		is_right_clicking = false


	
	
	


