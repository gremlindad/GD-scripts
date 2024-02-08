extends Node2D

var personal_group
var initial_position

export(Array, PackedScene) var tile_set


var tile_rotation_state = 0 setget ro_set





func ro_set(value):
	
	if value == 4:
		value = 0
	tile_rotation_state = value
	assign_tile(tile_rotation_state)



func assign_tile(rot_value):
	if get_child_count()>0:
		get_child(0).queue_free()
	#access array
	var tile_inst = tile_set[rot_value].instance()
	add_child(tile_inst)





func delete_already_placed_tile():
	#array of dictionaries containing tiles
	var tiles_in_way = get_world_2d().direct_space_state.intersect_point(position + Vector2(0,50),32,[],524288,false,true)
	for i in range(tiles_in_way.size()):
		
		if tiles_in_way[i]["collider"].is_in_group("FLOOR") and self.is_in_group("FLOOR"):
			tiles_in_way[i]["collider"].get_parent().queue_free()
			
			
			
		if tiles_in_way[i]["collider"].is_in_group("WALL") and self.is_in_group("WALL"):
			if tile_rotation_state == tiles_in_way[i]["collider"].get_parent().tile_rotation_state:
				tiles_in_way[i]["collider"].get_parent().queue_free()
	
#func _input(event):
#	if event.is_action_pressed("Rotate"):
#		self.tile_rotation_state +=1

func _on_FloorTileParent_tree_entered():
	delete_already_placed_tile()
	
	
	initial_position = tile_rotation_state
	
	
	if self.is_in_group("WALL"):
		match GlobalVariables.global_rotation_state:

			1,3:
				if initial_position == 0:
					initial_position = 1
				elif initial_position == 1:
					initial_position = 0
				elif initial_position == 2:
					initial_position = 3
				elif initial_position == 3:
					initial_position = 2
		
