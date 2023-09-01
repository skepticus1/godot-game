extends CharacterBody2D

const MAX_SPEED = 100
const ACCEL = 400
const ATTACK_DISTANCE = 30

var health = 30
var player = null
var current_dir = "none"

@onready var animated_sprite = $AnimatedSprite2D
@onready var detection_zone = $PlayerDetection



func _physics_process(delta):
	#print("player: ", player, ", Type: ", typeof(player))
	if player:
		#chase the player
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * MAX_SPEED
		update_animation(direction)
	else:
		# Stop and play idle animation
		velocity = Vector2.ZERO
		update_animation(Vector2.ZERO)
	move_and_slide()

func _on_player_detection_body_entered(body):
	#print("Entered: ", body, ", Type: ", typeof(body))
	if body.name == "Hero":
		print("here entered")
		player = body
		
func _on_player_detection_body_exited(body):
	if body.name == "Hero":
		print("hero exited")
		player = null
		
func update_animation(direction):
	var anim = "idle_down"
	if direction.length() > 0:
		#walking animations
		if abs(direction.x) > abs(direction.y):
			anim = "walk_" + ("right" if direction.x > 0 else "left")
		else:
			anim = "walk_" + ("down" if direction.y > 0 else "up")
	else:
		# idle animations based on last known direction
		if current_dir in ["up", "down", "left", "right"]:
			anim = "idle_" + current_dir
	animated_sprite.play(anim)
	current_dir = anim.replace("idle_", "").replace("walk_", "")
