extends StaticBody2D

@export var requiredGold = 50  # Set the required gold for the upgrade

var is_player_in_area = false
var is_interactable = true  # Set to false when the player successfully interacts

var enough_gold_panel: Panel
var not_enough_panel: Panel

func _ready():
	enough_gold_panel = $Enough_Gold
	not_enough_panel = $Not_Enough_Gold
	enough_gold_panel.visible = false
	not_enough_panel.visible = false

func _input(event):
	if is_player_in_area and event.is_action_pressed("interact") and is_interactable:
		if Game.Gold >= requiredGold:
			$Enough_Gold/AudioStreamPlayer2D.play()
			upgrade_attack()
		else:
			show_prompt_message("Not enough gold!")

func _on_area_2d_body_entered(body):
	if body.name == ("Hero"):
		is_player_in_area = true
		var message = "Press F to increase attack damage (-" + str(requiredGold) + " Gold)"
		show_prompt_message(message)

func _on_area_2d_body_exited(body):
	if body.name == ("Hero"):
		is_player_in_area = false
		enough_gold_panel.visible = false
		not_enough_panel.visible = false

func upgrade_attack():
	Game.Gold -= requiredGold
	Game.SwordDamage += 5  # Increase the player's attack by 5

func show_prompt_message(message):
	enough_gold_panel.visible = true
	enough_gold_panel.get_node("Label").text = message



