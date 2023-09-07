extends Marker2D

var HeroScene: PackedScene = preload("res://Player/Hero.tscn")

func _ready():
	spawn_player()
	$Sprite2D.visible = false
	
func spawn_player():
	var spawn_point = self.global_position
	
	var player_instance = HeroScene.instantiate()
	add_child(player_instance)
	
	player_instance.global_position = spawn_point
	
	
