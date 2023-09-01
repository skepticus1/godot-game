extends Node

const SAVE_PATH = "res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data = {
		"HeroHealth" : Game.HeroHealth,
		"HeroMana" : Game.HeroMana,
		"Gold" : Game.Gold,
		"SwordDamage" : Game.SwordDamage,
		"Kills" : Game.Kills,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.HeroHealth = current_line["HeroHealth"]
				Game.HeroMana = current_line["HeroMana"]
				Game.Gold = current_line["Gold"]
				Game.Kills = current_line["Kills"]
				Game.SwordDamage = current_line["SwordDamage"]
