extends Area2D





func _on_body_entered(body):
	print("player entered area")
	if body.name == "Hero":
		get_tree().change_scene_to_file("res://Maps/Crypt1/Crypt1.tscn")
