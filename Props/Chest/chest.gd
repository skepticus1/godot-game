extends Node2D



func _on_trigger_area_body_entered(body):
	if body.name == "Hero":
		print("press F to open")
