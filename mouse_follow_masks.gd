extends Node2D


func _physics_process(_delta):
	position = lerp(position,get_global_mouse_position(),0.2)

