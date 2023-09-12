extends StaticBody2D

var is_player_in_area = false


func _on_area_2d_body_entered(body):
	print('player has entered lectern2 zone')
	
	if body.name == "Hero":
		
		$Message.visible = true
		is_player_in_area = true
		


func _on_area_2d_body_exited(body):
	print('player has exited lectern2 zone')
	
	if body.name == "Hero":
		
		$Message.visible = false
		is_player_in_area = false
