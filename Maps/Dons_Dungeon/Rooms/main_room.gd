extends Node2D

# items to spawn
@export var ChestScene: PackedScene
@export var KeyScene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	spawn_random_item_at(Vector2(500, 300))  # Example position
	spawn_random_item_at(Vector2(600, 300))
	spawn_random_item_at(Vector2(700, 300))
	spawn_random_item_at(Vector2(800, 300))
	spawn_random_item_at(Vector2(900, 300))
	
func spawn_random_item_at(position):
	var scenes = [ChestScene, KeyScene]
	var random_scene = scenes[randi() % scenes.size()]
	
	var inst = random_scene.instantiate()
	
	add_child(inst)
	
	inst.global_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
