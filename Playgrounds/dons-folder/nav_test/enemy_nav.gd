extends CharacterBody2D


const speed = 100.0


@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D

func _ready():
	print("Initialized player: ", player, ", nav_agent: ", nav_agent)

func _physics_process(_delta: float) -> void:
	var dir = to_local(nav_agent.get_next_path_position()).normalized()
	velocity = dir * speed
	#print("dir: ", dir, " / ", "velocity: ", velocity)
	move_and_slide()
	
func makepath() -> void:
	if player:
		nav_agent.target_position = player.global_position
		#print("Target position", nav_agent.target_position)
	
func _on_timer_timeout():
	#print("timer timed out")
	makepath()


func _on_area_2d_area_entered(area):
	if area.is_in_group("player_group"):
		print("enemy collided")
