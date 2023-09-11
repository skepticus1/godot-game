extends Node2D

# packed scenes
var item1: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_s_01.tscn")
var item2: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_s_02.tscn")
var item3: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_s_03.tscn")
var item4: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_s_04.tscn")
var item5: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_s_05.tscn")
var item6: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_s_06.tscn")

# list of item scenes that can be spawned. 
var items = [
	item1, item2, item3, item4, item5, item6
]

func _ready():
	spawn_random_item()
	
func spawn_random_item():
	# 1 in 10 chance to not spawn anything
	if randi() % 10 == 0:
		queue_free()
		return
	
	var random_item_scene = items[randi() % items.size()]
	var item_inst = random_item_scene.instantiate()
	
	item_inst.global_position = self.global_position
	get_parent().call_deferred("add_child",item_inst)
	
	queue_free()
	
