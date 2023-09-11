extends StaticBody2D

var isBroken = false
var potionReference = preload("res://Playgrounds/KT/Assets/potion.tscn") # Load the potion scene
const potionSpawnChance = 0.4

func _ready():
	# Play the initial animation based on the isBroken state
	if isBroken:
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Broken")
			call_deferred("disableCollisionShape")
	else:
		var potStatus = $Area2D/breaking
		potStatus.play("Pot")

func _on_area_2d_area_entered(area):
	var hero = get_parent().get_node("Hero")
	if hero and hero.is_attacking and !isBroken:
		var potStatus = $Area2D/breaking
		if potStatus:
			potStatus.play("Break")
			isBroken = true
			call_deferred("disableCollisionShape")
			
			# Random chance to spawn a potion (40% chance)
			if randf() <= potionSpawnChance:
				spawnPotion()

func isPotBroken():
	return isBroken
	
func disableCollisionShape():
	get_node("CollisionShape2D").disabled = true
	
func spawnPotion():
	if potionReference:
		var potionInstance = potionReference.instantiate()
		if potionInstance:
			call_deferred("addPotion", potionInstance)

func placePotion(potionInstance):
	if potionInstance:
		call_deferred("addPotion", potionInstance)

func addPotion(potionInstance):
	if potionInstance:
		get_parent().add_child(potionInstance)
		potionInstance.global_position = self.global_position
