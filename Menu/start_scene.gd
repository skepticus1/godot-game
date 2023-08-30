extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	pass # Replace with function body.


func _on_credits_pressed():
	pass # Replace with function body.


func _on_test_area_pressed():
	pass # Replace with function body.


func _on_roger_pressed():
	pass # Replace with function body.


func _on_katie_pressed():
	get_tree().change_scene_to_file("res://Playgrounds/KT/world_one.tscn")


func _on_brenda_pressed():
	pass # Replace with function body.


func _on_dakota_pressed():
	pass # Replace with function body.


func _on_don_pressed():
	pass # Replace with function body.
