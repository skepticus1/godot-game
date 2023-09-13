extends CanvasLayer

@onready var death_scene = $DeathScene

var fade_rect
var kill_label
var grandparent_audio
var death_music

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_rect = death_scene.get_node("ColorRect")
	kill_label = death_scene.get_node("Panel/Label")
	death_music = death_scene.get_node("AudioStreamPlayer2D")
	
	# debugging
	if get_parent().get_parent().has_node("AudioStreamPlayer"):
		print("audio node found!")
		grandparent_audio = get_parent().get_parent().get_node("AudioStreamPlayer")
	else:
		print("audio NOT found!")
	
	death_scene.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.is_alive == false:
		kill_label.text = "Kills: %s" % Game.Kills
		handle_death()
		
func handle_death():
	set_process(false) # stop checking for death after handling it.
	death_scene.visible = true
	
	# fade the screen to black
	var fade_tween = get_tree().create_tween()
	fade_tween.tween_property(fade_rect, "color:a", 1, 5)
	
	# stop parent audio
	if grandparent_audio:
		grandparent_audio.stop()
		death_music.play()
	else: # start death music
		death_music.play()
		
		
