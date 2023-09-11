extends StaticBody2D

var isBroken = false

func _ready():
	# Play the initial animation based on the isBroken state
	if isBroken:
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Broken")
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
			
			
