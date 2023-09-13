extends CharacterBody2D

const MAX_SPEED = 100
const ACCEL = 400
const ATTACK_DISTANCE = 30

var player = null
var current_dir = "down"
var is_attacking = false
var is_alive = true
var damage = 25
var is_knockback = false



@export var health: int = 30
@export var key: PackedScene
@export var coin: PackedScene

@onready var current_health = 30
@onready var death_sound = $SkeletonSounds/SkeletonDeath
@onready var hurt_sound = $SkeletonSounds/SkeletonHurt
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite = $AnimatedSprite2D
@onready var detection_zone = $PlayerDetection
@onready var nav_agent = $NavigationAgent2D
@onready var death_timer = $DeathTimer
@onready var walking_sound = $SkeletonSounds/SkeletonMoving
@onready var walking_sound_playing = false


func _ready():
	add_to_group("Enemy")

func _physics_process(delta):
	if !is_alive:
		return
	check_health()
	# prevent moving when attacking
	if !animation_player.is_playing():
		is_attacking = false
	if is_attacking:
		return
	#print("player: ", player, ", Type: ", typeof(player))
	if player:
		# get new direction with nav agent
		make_path()
		var direction = to_local(nav_agent.get_next_path_position()).normalized()
		velocity = direction * MAX_SPEED
		update_animation(direction)
	else:
		# Stop and play idle animation
		velocity = Vector2.ZERO
		update_animation(Vector2.ZERO)
	
	if velocity != Vector2.ZERO and !walking_sound_playing:
		print("playing walking sound now")
		walking_sound.play()
		walking_sound_playing = true
	elif velocity == Vector2.ZERO and walking_sound_playing:
		walking_sound.stop()
		walking_sound_playing = false
	
		
	move_and_slide()

func _on_player_detection_body_entered(body):
	print(body)
	print("Entered: ", body, ", Type: ", typeof(body))
	if body.name == "Hero" || body.name == "player_nav":
		player = body
		
func _on_player_detection_body_exited(body):
	if body.name == "Hero" || body.name == "player_nav":
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

func make_path():
	if player:
		nav_agent.target_position = player.global_position

func _on_timer_timeout():
	#print("timer timed out")
	make_path()
	
func _on_attack_zone_body_entered(body):
	var anim_attack = ""
	if body.name == "Hero" and is_alive and Game.is_alive:
		# set attacking mode
		is_attacking = true
		print("attack zone entered by", body.name)
		#play animation
		if current_dir in ["up", "down", "left", "right"]:
			print("current direction:", current_dir)
			anim_attack = "slash_" + current_dir
			animation_player.play(anim_attack)

func _on_attack_zone_body_exited(body):
	if body.name == "Hero":
		print("Hero out of attack zone")
		is_attacking = false

func _on_slash_hit_box_body_entered(body):
	if body.name == "Hero" and Game.is_alive:
		print("Hero health: ", Game.HeroHealth)
		Game.HeroHealth -= damage
		

func check_health():
	if current_health != health:
		hurt_sound.play()
		current_health = health
	elif health <= 0:
		is_alive = false
		animation_player.play("death")
		walking_sound.stop()
		death_sound.play()
		death_timer.start()

func _on_death_timer_timeout():
	Game.Kills += 1
	
	var inst
	if randi() % 10 == 0:
		inst = key.instantiate()
	else:
		inst = coin.instantiate()
		
	inst.global_position = self.global_position
	var map = self.get_parent().get_parent()
	if map:
		map.add_child(inst)
	else:
		printerr("Couldn't find map to put coin/key in")
	queue_free()
