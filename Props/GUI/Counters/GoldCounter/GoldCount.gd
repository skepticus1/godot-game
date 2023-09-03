extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	var gold = Game.Gold
	text = str(gold)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updated_counter()


func updated_counter():
	var updated_gold = Game.Gold
	if text !=  str(Game.Gold):
		text = str(Game.Gold)
