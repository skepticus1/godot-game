extends StaticBody2D

@onready var pickup_sound = $AudioStreamPlayer2D
@onready var delay_timer = $Timer


func _on_key_body_entered(body):
	if body.name == "Hero":
		pickup_sound.play()
		Game.Keys += 1
		#print("Player has ", Game.Keys, " Keys")
		delay_timer.start()


func _on_timer_timeout():
		queue_free()
