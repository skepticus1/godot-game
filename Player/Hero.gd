extends CharacterBody2D

@onready var sword_sound = $HeroSoundEffects/SwordSlash
@onready var hurt_sound = $HeroSoundEffects/Hurt
@onready var walking_sound = $HeroSoundEffects/Walking
@onready var dash_sound = $HeroSoundEffects/SwordDash
@onready var wind_slash_sound = $HeroSoundEffects/WindSlash
@onready var current_health = Game.HeroHealth
@onready var current_mana = Game.HeroMana
@onready var mana_regen_timer = $ManaRegenTimer
@onready var effects_animation = $EffectsAnimation
@onready var wind_slash_animation = $WindSlash/AnimationPlayer

const max_speed = 300   # to lower speed change this
var friction = 1400	# this affects how fast it slows down
const idle_threshold = 10 # this is to determine when the character has stopped therefore changing it to standing animation

var input = Vector2.ZERO
var last_movement = Vector2.ZERO
var is_attacking = false
var is_alive = true
var nearby_interactable = null # used to know if the player is near an interactable object in the game world, such as a chest
var knockback_strength = 400

func _ready():
	pass

func _physics_process(delta):
	if current_health > Game.HeroHealth:
		hurt_sound.play()
		current_health = Game.HeroHealth
	else:
		current_health = Game.HeroHealth
	if current_mana != Game.HeroMana:
		current_mana = Game.HeroMana
	if Game.HeroHealth >= 1:
		if Input.is_action_just_pressed("attack1"):
			velocity = Vector2.ZERO
			is_attacking = true
			sword_attack()
			await sword_attack()
		elif Input.is_action_just_pressed("attack2") && current_mana >= 20:
			Game.HeroMana -= 20
			mana_regen_timer.start()
			velocity = Vector2.ZERO
			is_attacking = true
			sword_thrust()
			await sword_thrust()
		elif Input.is_action_just_pressed("wind slash") && current_mana >= 50:
			Game.HeroMana -= 50
			mana_regen_timer.start()
			is_attacking = true
			velocity = Vector2.ZERO
			wind_slash()
			sword_attack()
			await sword_attack()
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
			await sword_sound
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
			effects_animation.play("dashRight")
			dash_sound.play()
			get_node("AnimationPlayer").play("SwordThrustRight")
			friction = 50000
			velocity = last_movement * (max_speed * 25)
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.LEFT:
			effects_animation.play("dashLeft")
			dash_sound.play()
			get_node("AnimationPlayer").play("SwordThrustLeft")
			friction = 50000
			velocity = last_movement * (max_speed * 25)
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.DOWN:
			effects_animation.play("dashUp")
			dash_sound.play()
			get_node("AnimationPlayer").play("SwordThrustUp")
			friction = 50000
			velocity = last_movement * (max_speed * -25)
			if !sword_sound.playing:
				sword_sound.play()
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.UP:
			friction = 50000
			velocity = last_movement * (max_speed * -25)
			if !sword_sound.playing:
				sword_sound.play()
			effects_animation.play("dashDown")
			dash_sound.play()
			get_node("AnimationPlayer").play("SwordThrustDown")
			await get_node("AnimationPlayer").animation_finished
	is_attacking = false
	return is_attacking
	
func wind_slash():
	if is_attacking == true:
		if last_movement == Vector2.RIGHT:
			wind_slash_animation.play("windSlashRight")
			wind_slash_sound.play()
			get_node("AnimationPlayer").play("SwordAttackRight")
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.LEFT:
			wind_slash_animation.play("windSlashLeft")
			wind_slash_sound.play()
			get_node("AnimationPlayer").play("SwordAttackLeft")
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.DOWN:
			wind_slash_animation.play("windSlashUp")
			wind_slash_sound.play()
			get_node("AnimationPlayer").play("SwordAttackUp")
			await get_node("AnimationPlayer").animation_finished
		elif last_movement == Vector2.UP:
			wind_slash_animation.play("windSlashDown")
			wind_slash_sound.play()
			get_node("AnimationPlayer").play("SwordAttackDown")
			await get_node("AnimationPlayer").animation_finished
	is_attacking = false
	return is_attacking
	
func _on_attack_hit_box_body_entered(body):
	if body.is_in_group("Enemy"):
		body.health -= Game.SwordDamage
		apply_knockback(body)
	

# Interact with items in the world
# Handle interact being pressed default "F" key
func _input(event):
	if event.is_action_pressed("interact"):
		if nearby_interactable:
			nearby_interactable.interact()




func _on_wind_slash_body_entered(body):
	#print(body)
	if body.is_in_group("Enemy"):
		body.health -= Game.WindSlashDamage
		#print(body.name, " health is: ", body.health)
	elif body.name == "Skeleton":
		body.health -= Game.WindSlashDamage
	elif body.name == "Object":
		body.health -= Game.WindSlashDamage


func apply_knockback(body: CharacterBody2D):
	#print("knockback")
	var direction = body.global_position - self.global_position
	direction = direction.normalized()
	body.velocity = direction * knockback_strength
	body.is_knockback = true


func _on_mana_regen_timer_timeout():
	if Game.HeroMana < 100:
		Game.HeroMana += 1
