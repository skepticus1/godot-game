extends StaticBody2D

var is_player_in_area = false
#var lectern_label: Label


func _on_area_2d_body_entered(body):
	print('player has entered coffin zone')
	if body.name == "Hero":
		$Message1.visible = true
		#lectern_label.visible = true
		is_player_in_area = true
		


func _on_area_2d_body_exited(body):
	print('player has exited coffin zone')
	if body.name == "Hero":
		$Message1.visible = false
		#lectern_label.visible = false
		is_player_in_area = false
