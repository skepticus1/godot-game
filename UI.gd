extends CanvasLayer
class_name UI

@onready var gold_label = %GoldCounter

var gold_count = 0:
	set(new_gold_count):
		gold_count = new_gold_count
		_update_gold_counter()
func _ready():
	_update_gold_counter()

func _update_gold_counter():
	gold_label.text = str(gold_count)
	
func _on_collected(collectable) -> void:
	if collectable:
		gold_count += 5
	
