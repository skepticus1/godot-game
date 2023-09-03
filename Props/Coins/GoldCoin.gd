extends Area2D


func _on_body_entered(body):
	if body.name == "Hero":
		Game.Gold += 5
		queue_free()
