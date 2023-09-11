extends StaticBody2D

var is_player_in_area = false


func _on_area_2d_body_entered(body):
	print('player has entered left view lectern zone')
	
	if body.name == "Hero":
		
		$Message3.visible = true
		is_player_in_area = true
		


func _on_area_2d_body_exited(body):
	print('player has exited left view lectern zone')
	
	if body.name == "Hero":
		
		$Message3.visible = false
		is_player_in_area = false
