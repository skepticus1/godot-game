extends Area2D

var isBroken = false

func _ready():
	if isBroken:
		var animation_player = $breaking
		if animation_player:
			animation_player.play("Broken")
	else:
		var animation_player = $breaking
		animation_player.play("Pot")

func _on_body_entered(body):
	#skeleton
	var _hero = get_parent().get_parent().get_node("Hero")
	if body.name == "Hero" and not isBroken:
		#print("here")
		#var is_attacking = true
		#if hero.is_attacking == true:
			#print("attack1")
		var animation_player = $breaking
		if animation_player:
			animation_player.play("Break")
			isBroken = true

		#print(attack)
		#and hero.is_attacking:
		#print("here")
		#hero.sword_attack()
		#var animation_player = $breaking
		#if animation_player:
			#animation_player.play("Break")
			#isBroken = true
			
func _on_body_exited(body):
	pass
