extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	print('player has entered scene transition zone')
	if body.name == "Hero":
		get_tree().change_scene_to_file("res://Maps/Main_World/world_one.tscn") # Replace with function body.
