extends CharacterBody2D

const max_speed = 300   # to lower speed change this
const friction = 1400	# this affects how fast it slows down
const idle_threshold = 10 # this is to determine when the character has stopped therefore changing it to standing animation

var health = 100
var kills = 0
var gold = 0

var input = Vector2.ZERO
var last_movement = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)

func get_input():
	input.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	input.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))

	if input.x > 0:
		last_movement = Vector2.RIGHT
		get_node("AnimatedSprite2D").play("MoveRight")
	elif input.x < 0:
		last_movement = Vector2.LEFT
		get_node("AnimatedSprite2D").play("MoveLeft")
	elif input.y < 0:
		last_movement = Vector2.DOWN
		get_node("AnimatedSprite2D").play("MoveUp")
	elif input.y > 0:
		last_movement = Vector2.UP
		get_node("AnimatedSprite2D").play("MoveDown")
	else:
		play_idle_animation()

	return input.normalized()

func play_idle_animation():
	if velocity.length() < idle_threshold:
		if last_movement == Vector2.RIGHT:
			get_node("AnimatedSprite2D").play("IdleRight")
		elif last_movement == Vector2.LEFT:
			get_node("AnimatedSprite2D").play("IdleLeft")
		elif last_movement == Vector2.DOWN:
			get_node("AnimatedSprite2D").play("IdleUp")
		elif last_movement == Vector2.UP:
			get_node("AnimatedSprite2D").play("IdleDown")

func player_movement(delta):
	input = get_input()

	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	else:
		velocity = input * max_speed
		velocity = velocity.limit_length(max_speed)

	move_and_slide()

