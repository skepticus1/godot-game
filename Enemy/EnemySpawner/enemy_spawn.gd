extends Marker2D

var EnemyScene: PackedScene = preload("res://Enemy/Skeleton/Skeleton.tscn")

const HEALTH = 100
const NUM_OF_ENEMIES = 10
const MIN_RAD = 50
const MAX_RAD = 100
const SPAWN_DELAY = 250 #msecs

var enemies_spawned = 0

func _ready():
	pass
	
func _on_area_2d_body_entered(body):
	if body.name == "Hero" and enemies_spawned < NUM_OF_ENEMIES:
		spawn_enemies()
		
func spawn_enemies():
	while enemies_spawned < NUM_OF_ENEMIES:
		spawn_enemy()
		enemies_spawned += 1
		await get_tree().create_timer(1.0).timeout
	
func spawn_enemy():
	var spawn_point = random_position_around_marker()
	
	var enemy_instance = EnemyScene.instantiate()
	add_child(enemy_instance)
	
	enemy_instance.global_position = spawn_point

func random_position_around_marker() -> Vector2:
	# generate a random angle
	var angle = deg_to_rad(randf() * 360)
	
	# generate a random direction within the spawn radius
	var distance = randf() * (MAX_RAD - MIN_RAD) + MIN_RAD
	
	# calc the x and y offsets
	var x_offset = distance * cos(angle)
	var y_offset = distance * sin(angle)
	
	# return spawn position
	return self.global_position + Vector2(x_offset, y_offset)




func _on_area_2d_body_exited(body):
	pass # Replace with function body.
