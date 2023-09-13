extends Area2D

@onready var audio_player = $AudioStreamPlayer2D
@onready var delay_timer = $Timer


func _on_body_entered(body):
	if body.name == "Hero":
		Game.Gold += 5
		play_pickup_sound()

func play_pickup_sound():
	audio_player.play()
	delay_timer.start()


func _on_timer_timeout():
	queue_free()
