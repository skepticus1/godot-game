extends StaticBody2D

var canInteract = false
# Track if the potion was already used
var wasPotionUsed = false  

func _ready():
	pass

#If hero needs healing and potion is there Hero can interact  
func _on_area_2d_body_entered(body):
	if body.name == "Hero" && !wasPotionUsed && Game.HeroHealth < 100:
		canInteract = true
	else:
		canInteract = false

#Potion stays when hero exits area
func _on_area_2d_body_exited(body):
	if body.name == "Hero":
		canInteract = false


func _process(_delta):
	if canInteract && Game.HeroHealth < 100:
		print("idk")
		Game.HeroHealth += 20
		wasPotionUsed = true
		queue_free()

 
