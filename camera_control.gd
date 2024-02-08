extends Camera2D

signal camera_has_moved

var target_zoom: float = 1.0
const MIN_ZOOM: float = 0.8
const MAX_ZOOM: float = 4.0
const INCREMENT: float = 0.1
const ZOOM_SPEED: float = 8.0

var mouse_cam_offset = Vector2(960,540)
var mouse_position_capture = Vector2.ZERO

func _ready():
	pass
func _unhandled_input(event):
	if event is InputEventMouseButton:	
		
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				zoom_in()
				emit_signal("camera_has_moved")
			elif event.button_index == BUTTON_WHEEL_DOWN:
				zoom_out()
				emit_signal("camera_has_moved")
	
	
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("MMB") or Input.is_action_pressed("space"):
			position -= event.relative *zoom
			emit_signal("camera_has_moved")
			
			


func _physics_process(delta):
		
	zoom = lerp(zoom,target_zoom*Vector2.ONE,ZOOM_SPEED*delta)
	set_physics_process(not target_zoom == zoom.x)
	pass
	
	
		



func zoom_in():
	target_zoom = max(target_zoom-INCREMENT,MIN_ZOOM)
	#mouse_position_capture = get_global_mouse_position().snapped(Vector2(100,58)) -mouse_cam_offset
	set_physics_process(true)
func zoom_out():
	target_zoom = min(target_zoom+INCREMENT,MAX_ZOOM)
	#mouse_position_capture = get_global_mouse_position().snapped(Vector2(100,58)) -mouse_cam_offset
	set_physics_process(true)



