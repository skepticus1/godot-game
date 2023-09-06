extends Node2D


# angle var to keep track of rotation
var angle: float = 0

# speed of orbit
var speed: float = 2

# radius of orbit
var radius: float = 50

func _process(delta):
	# update the angle based on speed
	angle += speed * delta
	
	# sine/cosine to get new x & y position
	var x = radius * cos(angle)
	var y = radius * sin(angle)
	
	# set the rel position
	position = Vector2(x, y)
