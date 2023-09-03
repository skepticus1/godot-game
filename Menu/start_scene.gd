extends Node2D

@onready var musicPlayer = $MusicPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	Utilities.saveGame()
	Utilities.loadGame()
	musicPlayer.play(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Maps/Crypt1/Crypt1.tscn")
	musicPlayer.stream_paused = !musicPlayer.stream_paused

func _on_credits_pressed():
	pass # Replace with function body.


func _on_test_area_pressed():
	get_tree().change_scene_to_file("res://Maps/DevMap/DevMap.tscn")


func _on_roger_pressed():
	pass


func _on_katie_pressed():
	pass #get_tree().change_scene_to_file("res://Playgrounds/KT/world_one.tscn")


func _on_brenda_pressed():
	pass # Replace with function body.


func _on_dakota_pressed():
	get_tree().change_scene_to_file("res://Playgrounds/Dakota/dakotasscene1.tscn")
	


func _on_don_pressed():
	get_tree().change_scene_to_file("res://Playgrounds/dons-folder/scenes/dons-scene.tscn")
