extends Node2D

export(Texture) var texture #= preload("res://Art/2 - 1 ratio art/grid200100.png")

func _ready():
	update()


func _draw():
	var viewport_size = get_viewport_rect().size
	var cam = get_parent().get_node("Camera2D")
	var size = cam.zoom*viewport_size
	
	
	for i in range(
	int(cam.position.x/viewport_size.x)-1,
	int((size.x+cam.position.x)/viewport_size.x)+2):
		for j in range(
		int(cam.position.y/viewport_size.y)-1,
		int((size.y+cam.position.y)/viewport_size.y)+2):
			draw_texture(texture,Vector2(i*texture.get_width(),j*texture.get_height()))
		

func _on_Camera2D_camera_has_moved():
	update()
