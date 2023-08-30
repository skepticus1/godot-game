extends CharacterBody2D

const max_speed = 200
const accel = 800
const friction = 500

var input = Vector2.ZERO
var current_dir = "none"

@onready var anim = get_node("AnimationPlayer")

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
	return input.normalized()
	
func player_movement(delta):
	input = get_input()
	var anim_name = "idle_down"
	
	# slows and stops the player
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
		# choose idle animation based on last direction
		if current_dir == "up":
			anim_name = "idle_up"
		elif current_dir == "down":
			anim_name = "idle_down"
		elif current_dir == "right":
			anim_name = "idle_right"
		elif current_dir == "left":
			anim_name = "idle_left"
		else:
			anim_name = "idle_down"
	# speeds up the character to a max_speed
	else:
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
		
		# Determine the current direction
		if input.y < 0:
			current_dir = "up"
			anim_name = "walk_up"
		elif input.y > 0:
			current_dir = "down"
			anim_name = "walk_down"
		elif input.x > 0:
			current_dir = "right"
			anim_name = "walk_right"
		elif input.x < 0:
			current_dir = "left"
			anim_name = "walk_left"
	
	# play the correct animation
	anim.play(anim_name)
	move_and_slide()
