extends StaticBody2D

var canInteract = false
var wasPotionUsed = false  # Track if the potion was already used

func _ready():
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Hero" && !wasPotionUsed && Game.HeroHealth < 100:
		print("interacting")
		canInteract = true

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

# Function to retrieve the isBroken status of the BreakablePots
func get_pot_status() -> bool:
	var pots = get_parent().get_node(".")  # Adjust the path to your BreakablePots
	if pots:
		return pots.isBroken
	else:
		return false  # Return a default value if the BreakablePots node cannot be found
