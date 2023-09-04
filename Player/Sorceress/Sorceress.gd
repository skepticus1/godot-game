extends CharacterBody2D

@export var fireballInstance : PackedScene
@onready var startCast = $EndOfStaff

const max_speed = 300   # to lower speed change this
const friction = 1400	# this affects how fast it slows down
const idle_threshold = 10 # this is to determine when the character has stopped therefore changing it to standing animation

var input = Vector2.ZERO
var last_movement = Vector2.ZERO
var is_attacking = false
var is_alive = true
var nearby_interactable = null # used to know if the player is near an interactable object in the game world, such as a chest

func _physics_process(delta):
	if Game.HeroHealth >= 1:
		if Input.is_action_just_pressed("attack1"):
			is_attacking = true
			cast_spell()
			await cast_spell()
		else:
			if is_attacking == false:
				player_movement(delta)
	elif is_alive == true:
		is_alive = false
		get_node("AnimationPlayer").play("death")
		#get_tree().change_scene_to_file("res://Playgrounds/Roger/roger_start_scene.tscn")

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))

	if input.x > 0:
		last_movement = Vector2.RIGHT
		get_node("AnimatedSprite2D").play("moveRight")
	elif input.x < 0:
		last_movement = Vector2.LEFT
		get_node("AnimatedSprite2D").play("moveLeft")
	elif input.y < 0:
		last_movement = Vector2.DOWN
		get_node("AnimatedSprite2D").play("moveUp")
	elif input.y > 0:
		last_movement = Vector2.UP
		get_node("AnimatedSprite2D").play("moveDown")
	else:
		play_idle_animation()

	return input.normalized()

func play_idle_animation():
	if velocity.length() < idle_threshold:
		if is_attacking == false:
			if last_movement == Vector2.RIGHT:
				get_node("AnimatedSprite2D").play("idleRight")
			elif last_movement == Vector2.LEFT:
				get_node("AnimatedSprite2D").play("idleLeft")
			elif last_movement == Vector2.DOWN:
				get_node("AnimatedSprite2D").play("idleUp")
			elif last_movement == Vector2.UP:
				get_node("AnimatedSprite2D").play("idleDown")
		else:
			cast_spell()

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

func cast_spell():
	if is_attacking == true:
		if last_movement == Vector2.RIGHT:
			get_node("AnimationPlayer").play("castRight")
			await get_node("AnimationPlayer").animation_finished
			fireball()
		elif last_movement == Vector2.LEFT:
			get_node("AnimationPlayer").play("castLeft")
			await get_node("AnimationPlayer").animation_finished
			fireball()
		elif last_movement == Vector2.DOWN:
			get_node("AnimationPlayer").play("castUp")
			await get_node("AnimationPlayer").animation_finished
			fireball()
		elif last_movement == Vector2.UP:
			get_node("AnimationPlayer").play("castDown")
			await get_node("AnimationPlayer").animation_finished
			fireball()
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
		
func fireball():
	var fireballTemp = fireballInstance.instantiate()
	owner.add_child(fireballTemp)
	fireballTemp.transform = startCast.global_transform
	var target = get_global_mouse_position()
	var direction_to_target = fireballTemp.global_position.direction_to(target).normalized()
	fireballTemp.set_direction(direction_to_target)

# Interact with items in the world
# Handle interact being pressed default "F" key
func _input(event):
	if event.is_action_pressed("interact"):
		if nearby_interactable:
			nearby_interactable.interact()
