extends StaticBody2D

var isBroken = false

func _ready():
	if isBroken:
		print("Broken")
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Broken")
	else:
		print("pot")
		var potStatus = $Area2D/breaking
		potStatus.play("Pot")

func _on_area_2d_area_entered(area):
	print("hello")
	var hero = get_parent().get_node("Hero") 
	if hero and hero.is_attacking and not isBroken:
		print("here")
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Break")
			isBroken = true
