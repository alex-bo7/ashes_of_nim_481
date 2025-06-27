extends Control

@export var label: Label

func _ready():
	var final_utility = GameManager.current_state.utility
	
	Records.games_played += 1
	if final_utility == 1: # if Player's utility is 1, Player won
		label.text = "Player won"
		Records.player_wins += 1
	elif final_utility == -1: # if Player's utility is -1, Player lost (CPU won)
		label.text = "CPU won"
	else: # just in case
		label.text = "Error/Draw (Utility: " + str(final_utility) + ")"


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu/main_menu.tscn")
