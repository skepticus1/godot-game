extends CanvasLayer



@onready var death_label = $Panel/Label


func _ready():
	pass # Replace with function body.


func display_death_message():
	death_label.text = "You killed %s enemies!" % Game.Kills



func _on_button_pressed():
		get_tree().change_scene_to_file("res://Menu/start_scene.tscn")
