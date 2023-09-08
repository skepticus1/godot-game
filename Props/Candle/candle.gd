extends Node2D

@onready var light = $shadow
var flicker_interval = 0.1
var time_since_last_flicker = 0.0

func _ready():
	set_process(true)
	
func _process(delta):
	time_since_last_flicker += delta
	if time_since_last_flicker > flicker_interval:
		flicker_light()
		time_since_last_flicker = 0.0
	
func flicker_light():
	var target_scale = randf_range(2.6, 2.7)
	var target_energy = randf_range(1.0, 1.1)
	var target_x_pos = randf_range(-0.5, 0.5)
	var target_y_pos = randf_range(-0.5, 0.5)
	
	light.scale = Vector2(target_scale, target_scale)
	light.energy = target_energy
	light.position += Vector2(target_x_pos, target_y_pos)
