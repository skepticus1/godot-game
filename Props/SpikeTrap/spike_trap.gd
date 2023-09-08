extends Node2D

@onready var trigger_area = $spike_trap_trigger_area
@onready var hit_area = $spike_trap_hit_area

func _ready():
	hit_area.hide()
	trigger_area.show()

func _on_spike_trap_trigger_area_body_entered(body):
	if body.name == "Hero":
		trigger_spikes()
		
func trigger_spikes():
	trigger_area.hide()
	hit_area.show()

