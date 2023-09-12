extends RigidBody2D


@onready var audio_player = $AudioStreamPlayer2D
@onready var delay_timer = $Timer

func _ready():
	# ensure the coin doesn't slide or spin too much.
	self.linear_damp = 3.0
	self.angular_damp = 1.0
	self.gravity_scale = 0.0
	

func _on_coin_pickup_area_body_entered(body):
	if body.name == "Hero":
		Game.Gold += 5
		play_pickup_sound()

func play_pickup_sound():
	audio_player.play()
	delay_timer.start()

func _on_timer_timeout():
	queue_free()
