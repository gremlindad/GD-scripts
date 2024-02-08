extends YSort


onready var Cursor = get_parent().get_node("Cursor")








func _on_Cursor_place_tile(value,rot_value):
	
	var new_tile = value.instance()
			
	new_tile.tile_rotation_state = rot_value
	new_tile.position = Cursor.get_node("Cursor").global_position
	add_child(new_tile)
			
func _on_Cursor_remove_tile():
	delete_tile(TileState.state)
	
func delete_tile(tilestate):
	#we need the rotation state of the cursor tile
	
	
	var tiles = get_world_2d().direct_space_state.intersect_point(
			get_global_mouse_position(),32,[],524288,false,true)


	for t in tiles:
		if t["collider"].is_in_group("FLOOR") and Cursor.tile_instance.is_in_group("FLOOR"):
				t["collider"].get_parent().queue_free()
		if t["collider"].is_in_group("WALL") and Cursor.tile_instance.is_in_group("WALL"):
			if t["collider"].get_parent().tile_rotation_state == Cursor.rotation_count:
				t["collider"].get_parent().queue_free()










#rotate world######################################





var current_rotation_state =0

#var global_rotation_state = 0



func _input(event: InputEvent):
	if event.is_action_pressed("full_rotate_u"):
		GlobalVariables.global_rotation_state = GlobalVariables.global_rotation_state + 1
		call_deferred("rotate_scene")
		recentre_aft_rotation()

func rotate_scene():
	for tile in get_children():
		var iso_south_position = IsoMathsFunctions.convert_screenspace_to_south_iso(tile.position)
		var iso_east_pos = IsoMathsFunctions.convert_east_iso_to_screenspace(iso_south_position)
		tile.position = IsoMathsFunctions.convert_east_iso_to_screenspace(iso_south_position)
		#tile.tile_rotation_state+=1
		offset_tile_rotation(tile)

func recentre_aft_rotation():
	var cam = get_parent().get_node("CameraMaster/Camera2D")
	var current_screen_size_x = get_viewport_rect().size.x * cam.zoom.x
	var current_screen_size_y = get_viewport_rect().size.y * cam.zoom.y
	
	
	var offset = Vector2(current_screen_size_x/2,current_screen_size_y/2)
	var screen_centre = cam.position + offset
	var cam_po_s_iso = IsoMathsFunctions.convert_screenspace_to_south_iso(screen_centre)
	var cam_new_po = IsoMathsFunctions.convert_east_iso_to_screenspace(cam_po_s_iso) - offset
	cam.position = cam_new_po
	
func offset_tile_rotation(tile):
	
	if tile.is_in_group("FLOOR"):
		match tile.initial_position:
			0,1,2,3:
				match GlobalVariables.global_rotation_state:
					1:
						tile.tile_rotation_state+=1
						tile.position += Vector2(100,-50)
					2:
						tile.tile_rotation_state+=1
						tile.position += Vector2(100,-50)
						
					3:
						tile.tile_rotation_state+=1
						tile.position += Vector2(100,-50)
						#tile.position += Vector2(100,-50)
						
					0:
						tile.tile_rotation_state+=1
						tile.position += Vector2(100,-50)
						
#			
	if tile.is_in_group("WALL"):
		
		match tile.initial_position:
			0:
				match GlobalVariables.global_rotation_state:
					1:
						tile.tile_rotation_state =1
						tile.position += Vector2(100,-50)
					2:
						tile.tile_rotation_state =0
					3:
						tile.tile_rotation_state =1
						tile.position += Vector2(100,-50)
					0:
						tile.tile_rotation_state =0
			1:
				match GlobalVariables.global_rotation_state:
					2:
						tile.tile_rotation_state = 1
						tile.position += Vector2(100,-50)
					3:
						tile.tile_rotation_state =0
					0:
						tile.tile_rotation_state = 1
						tile.position += Vector2(100,-50)
					1:
						tile.tile_rotation_state = 0
			
			2:
				match GlobalVariables.global_rotation_state:
					1:
						tile.tile_rotation_state =3
						tile.position += Vector2(100,-50)
					2:
						tile.tile_rotation_state =2
						tile.position += Vector2(100,-50)
					3:
						tile.tile_rotation_state =3
						tile.position += Vector2(100,-50)
					0:
						tile.tile_rotation_state =2
						tile.position += Vector2(100,-50)
						
			3:
				match GlobalVariables.global_rotation_state:
					2:
						tile.tile_rotation_state = 3
						tile.position += Vector2(100,-50)
					3:
						tile.tile_rotation_state =2
						tile.position += Vector2(100,-50)
						
					0:
						tile.tile_rotation_state = 3
						tile.position += Vector2(100,-50)
						
					1:
						tile.tile_rotation_state = 2
						tile.position += Vector2(100,-50)
