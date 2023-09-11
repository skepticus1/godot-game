extends Node2D

# packed scenes
var item1: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_01.tscn")
var item2: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_02.tscn")
var item3: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_03.tscn")
var item4: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_04.tscn")
var item5: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_05.tscn")
var item6: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_06.tscn")
var item7: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_07.tscn")
var item8: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_08.tscn")
var item9: PackedScene = preload("res://Maps/Dons_Dungeon/Props/Crates/crate_l_09.tscn")

# list of item scenes that can be spawned. 
var items = [
	item1, item2, item3, item4, item5, item6, item7, item8, item9
]

func _ready():
	spawn_random_item()
	
func spawn_random_item():
	var random_item_scene = items[randi() % items.size()]
	var item_inst = random_item_scene.instantiate()
	
	item_inst.global_position = self.global_position
	get_parent().call_deferred("add_child",item_inst)
	
	queue_free()
	
