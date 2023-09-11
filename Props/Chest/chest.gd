extends Node2D


@export var key: PackedScene
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
	
	var inst = key.instantiate()
	get_parent().add_child(inst)
	inst.global_position = self.global_position
