extends CanvasLayer

@onready var healthProgress = $HealthBarProgress
# Called when the node enters the scene tree for the first time.
func _ready():
	healthProgress.set_value(int(Game.HeroHealth))
	print(healthProgress.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if healthProgress.value != int(Game.HeroHealth):
		healthProgress.set_value(int(Game.HeroHealth))
		print("This is the bar value" , healthProgress.value)
