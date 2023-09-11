extends Node2D

# packed scenes
var item1: PackedScene = preload("res://Props/Chest/chest.tscn")

# list of item scenes that can be spawned. 
var items = [
	item1
]

func _ready():
	spawn_random_item()
	
func spawn_random_item():
	# 1 in 10 chance to not spawn anything
	if randi() % 5 == 0:
		queue_free()
		return
		
	var random_item_scene = items[randi() % items.size()]
	var item_inst = random_item_scene.instantiate()
	
	item_inst.global_position = self.global_position
	get_parent().call_deferred("add_child",item_inst)
	
	queue_free()
	
