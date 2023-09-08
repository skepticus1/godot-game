extends StaticBody2D

var isBroken = false
var potionReference = null

func _ready():
	
	potionReference = get_node(".")  
	
	if isBroken:
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Broken")
			isBroken = true
	else:
		var potStatus = $Area2D/breaking
		potStatus.play("Pot")

func _on_area_2d_area_entered(area):
	var hero = get_parent().get_node("Hero")
	if hero and hero.is_attacking and !isBroken:
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Break")
			isBroken = true

func isPotBroken():
	return isBroken
