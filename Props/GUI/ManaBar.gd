extends CanvasLayer

@onready var manaProgress = $ManaProgressBar
# Called when the node enters the scene tree for the first time.
func _ready():
	manaProgress.set_value(int(Game.HeroMana))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if manaProgress.value != int(Game.HeroMana):
		manaProgress.set_value(int(Game.HeroMana))
		
