extends Node


const TILE_WIDTH = 200
const TILE_HEIGHT = 100
const HALF_WIDTH = TILE_WIDTH/2
const HALF_HEIGHT = TILE_HEIGHT/2


#south##################################################


static func convert_screenspace_to_south_iso(screen_vector2:Vector2) -> Vector2:
	var iso_conversion : Vector2 
	
	iso_conversion.x = screen_vector2.x/TILE_WIDTH + screen_vector2.y/TILE_HEIGHT
	iso_conversion.y = screen_vector2.y/TILE_HEIGHT - screen_vector2.x/TILE_WIDTH
	
	return iso_conversion 

static func convert_south_iso_to_screenspace(iso_vector2:Vector2)->Vector2:
	var screenspace_conversion : Vector2
	
	screenspace_conversion.x = HALF_WIDTH*(iso_vector2.x-iso_vector2.y)
	screenspace_conversion.y = HALF_HEIGHT*(iso_vector2.x+iso_vector2.y)
	
	return screenspace_conversion
	
static func find_relative_iso_south_position(new_origin:Vector2,new_position:Vector2)-> Vector2:

	var difference = new_position - new_origin 
	
	return convert_screenspace_to_south_iso(difference)
	

#### east

static func convert_screenspace_to_east_iso(screen_vector2:Vector2) -> Vector2:
	var iso_conversion : Vector2 
	
	iso_conversion.x = screen_vector2.x/TILE_WIDTH - screen_vector2.y/TILE_HEIGHT
	iso_conversion.y = screen_vector2.y/TILE_HEIGHT + screen_vector2.x/TILE_WIDTH
	
	return iso_conversion 

static func convert_east_iso_to_screenspace(iso_vector2:Vector2)->Vector2:
	var screenspace_conversion : Vector2
	
	
	screenspace_conversion.x = HALF_WIDTH*(iso_vector2.x + iso_vector2.y)
	screenspace_conversion.y = HALF_HEIGHT*(iso_vector2.y - iso_vector2.x) 
	
	return screenspace_conversion
