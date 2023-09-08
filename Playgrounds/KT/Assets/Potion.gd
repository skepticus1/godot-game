extends StaticBody2D

var canInteract = false
var wasPotionUsed = false  # Track if the potion was already used

func _ready():
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Hero" && !wasPotionUsed && Game.HeroHealth < 100:
		print("Want a potion?")
		canInteract = true
	else:
		canInteract = false
		print("No potion for you")

func _on_area_2d_body_exited(body):
	print(canInteract)
	if body.name == "Hero":
		canInteract = false

func _process(_delta):
	if canInteract && Game.HeroHealth < 100:
		print("idk")
		Game.HeroHealth += 20
		wasPotionUsed = true
		queue_free()

func get_pot_status() -> bool:
	var pots = get_parent().get_node(".") 
	if pots:
		return pots.isPotBroken
	else:
		return false  
