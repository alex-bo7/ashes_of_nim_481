extends Control

@export var label: Label

func _ready():
	var final_utility = GameManager.current_state.utility
	
	if final_utility == 1: # if Player's utility is 1, Player won
		label.text = "Player won"
	elif final_utility == -1: # if Player's utility is -1, Player lost (CPU won)
		label.text = "CPU won"
	else: # just in case
		label.text = "Error/Draw (Utility: " + str(final_utility) + ")"
