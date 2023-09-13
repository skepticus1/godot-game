extends Node2D

# num of coins to spawn
const COINS = 25

# ejection force
const EJECT_FORCE = 200

@onready var coin_spawn_sound = $CoinSpawnSound

@export var key: PackedScene
var CoinScene: PackedScene = preload("res://Props/Coins/Coin_with_Physics/coin_physics.tscn")
var HealthPotScene: PackedScene = preload("res://Props/Pots/Health_Potion.tscn")

var is_player_in_area = false
var is_locked = true
var is_open = false

func _input(event):
	if is_player_in_area and event.is_action_pressed("interact"):
		if is_locked:
			if Game.Keys >= 1:
				Game.Keys -= 1
				_handle_interact()
		elif is_locked == false and is_open == false:
			_handle_interact()

func _on_trigger_area_body_entered(body):
	if body.name == "Hero":
		if is_open:
			return
		if is_locked:
			$Locked.visible = true
		elif !is_locked:	
			$Unlocked.visible = true
		
		is_player_in_area = true

func _on_interaction_area_body_exited(body):
	if body.name == "Hero":
		$Unlocked.visible = false
		$Locked.visible = false
		
		is_player_in_area = false
		
func _handle_interact():
	$close.visible = false
	$open.visible = true
	is_open = true
	$OpenSound.play()
	
	var health_pot = HealthPotScene.instantiate()
	health_pot.global_position = self.global_position
	get_parent().add_child(health_pot)
	
	#spawn and eject items (coins for now)
	spawn_and_eject_items()
	
func spawn_and_eject_items():
	for _i in range(COINS):
		coin_spawn_sound.play()
		var coin = CoinScene.instantiate()
		coin.global_position = self.global_position
		
		# calc a random ejection angle and convert it to a direction
		var angle = deg_to_rad(randf() * 360)
		var direction = Vector2(cos(angle), sin(angle))
		
		# apply random force
		var random_force = EJECT_FORCE + randi_range(-50, 50)
		coin.linear_velocity = direction * random_force
		
		get_parent().add_child(coin)
		
		await get_tree().create_timer(0.15).timeout
