extends Node2D

@onready var trigger_area = $spike_trap_trigger_area
@onready var hit_area = $spike_trap_hit_area

var knockback_strength = 400

func _ready():
	hit_area.hide()
	trigger_area.show()

func _on_spike_trap_trigger_area_body_entered(body):
	if body.name == "Hero":
		trigger_spikes()
		apply_knockback(body)
		Game.HeroHealth -= 10
		
func trigger_spikes():
	trigger_area.hide()
	hit_area.show()
	
func apply_knockback(body: CharacterBody2D):
	print("knockback")
	var direction = body.global_position - self.global_position
	direction = direction.normalized()
	
	body.velocity = direction * knockback_strength

