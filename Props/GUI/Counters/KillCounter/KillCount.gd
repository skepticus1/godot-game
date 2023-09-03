extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	var kills = Game.Kills
	text = str(kills)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	updated_kills()
	
func updated_kills():
	if text != str(Game.Kills):
		text = str(Game.Kills)
