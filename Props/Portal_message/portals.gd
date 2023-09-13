extends StaticBody2D

@onready var label = $Panel
 
func _on_area_2d_body_entered(body):
	if body.name == ("Hero"):
		label.visible = true
	else: label.visible = false


func _on_area_2d_body_exited(body):
	if body.name == ("Hero"):
		label.visible = false


