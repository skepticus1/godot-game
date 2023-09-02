extends StaticBody2D




func _on_key_body_entered(body):
	if body.name == "Hero":
		Game.Keys += 1
		print("Player has ", Game.Keys, " Keys")
		queue_free()
