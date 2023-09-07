extends CharacterBody2D

@onready var hit_flash = $HitFlash
@onready var sword_sound = $HeroSoundEffects/SwordSlash
@onready var hurt_sound = $HeroSoundEffects/Hurt
@onready var walking_sound = $HeroSoundEffects/Walking
@onready var current_health = Game.HeroHealth

const max_speed = 300   # to lower speed change this
const friction = 1400	# this affects how fast it slows down
const idle_threshold = 10 # this is to determine when the character has stopped therefore changing it to standing animation


var input = Vector2.ZERO
var last_movement = Vector2.ZERO
var is_attacking = false
var is_alive = true
var nearby_interactable = null # used to know if the player is near an interactable object in the game world, such as a chest

func _physics_process(delta):
	if current_health != Game.HeroHealth:
		frameFreeze(0.05, 0.6)
		hurt_sound.play()
		current_health = Game.HeroHealth
	if Game.HeroHealth >= 1:
		if Input.is_action_just_pressed("attack1"):
			velocity = Vector2.ZERO
			is_attacking = true
			sword_attack()
			await sword_attack()
		elif Input.is_action_just_pressed("attack2"):
			velocity = Vector2.ZERO
			is_attacking = true
			sword_thrust()
			await sword_thrust()
		else:
			if is_attacking == false:
				player_movement(delta)
	elif is_alive == true:
		is_alive = false
		Game.is_alive = false
		get_node("AnimationPlayer").play("Death")
		#get_tree().change_scene_to_file("res://Playgrounds/Roger/roger_start_scene.tscn")

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

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
		if is_attacking == false:
			if last_movement == Vector2.RIGHT:
				get_node("AnimatedSprite2D").play("IdleRight")
			elif last_movement == Vector2.LEFT:
				get_node("AnimatedSprite2D").play("IdleLeft")
			elif last_movement == Vector2.DOWN:
				get_node("AnimatedSprite2D").play("IdleUp")
			elif last_movement == Vector2.UP:
				get_node("AnimatedSprite2D").play("IdleDown")
		else:
			sword_attack()

func player_movement(delta):
	input = get_input()

	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
			if walking_sound.playing:
				walking_sound.stop()
	else:
		if !walking_sound.playing:
			walking_sound.play()
		velocity = input * max_speed
		velocity = velocity.limit_length(max_speed)

	move_and_slide()

func sword_attack():
	if is_attacking == true:
		if last_movement == Vector2.RIGHT:
			get_node("AnimationPlayer").play("SwordAttackRight")
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.LEFT:
			get_node("AnimationPlayer").play("SwordAttackLeft")
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.DOWN:
			get_node("AnimationPlayer").play("SwordAttackUp")
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.UP:
			if !sword_sound.playing:
				sword_sound.play()
			get_node("AnimationPlayer").play("SwordAttackDown")
			await get_node("AnimationPlayer").animation_finished

	is_attacking = false
	return is_attacking
	
func sword_thrust():
	if is_attacking == true:
		if last_movement == Vector2.RIGHT:
			get_node("AnimationPlayer").play("SwordThrustRight")
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.LEFT:
			get_node("AnimationPlayer").play("SwordThrustLeft")
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.DOWN:
			get_node("AnimationPlayer").play("SwordThrustUp")
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.UP:
			if !sword_sound.playing:
				sword_sound.play()
			get_node("AnimationPlayer").play("SwordThrustDown")
			await get_node("AnimationPlayer").animation_finished
	is_attacking = false
	return is_attacking
	

func _on_attack_hit_box_body_entered(body):
	print("Function is running! Entered body is: ", body.name) 
	if body.is_in_group("Enemy"):
		body.health -= Game.SwordDamage
		print(body.name, " health is: ", body.health)
	elif body.name == "Enemy":
		print("Hit enemy")
	elif body.name == "Object":
		print("Hit object")

# Interact with items in the world
# Handle interact being pressed default "F" key
func _input(event):
	if event.is_action_pressed("interact"):
		if nearby_interactable:
			nearby_interactable.interact()
			
func frameFreeze(timeScale, duration):
	Engine.time_scale = timeScale
	hit_flash.play("hitFlash")
	await(get_tree().create_timer(duration * timeScale).timeout)
	Engine.time_scale = 1.0


