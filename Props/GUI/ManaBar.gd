extends CanvasLayer

@onready var manaProgress = $ManaProgressBar
@onready var current_mana = Game.HeroMana

# Called when the node enters the scene tree for the first time.
func _ready():
	manaProgress.value = int(current_mana)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_mana != Game.HeroMana:
		current_mana = Game.HeroMana
		manaProgress.value = current_mana
