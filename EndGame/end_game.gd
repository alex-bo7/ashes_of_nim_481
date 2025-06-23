extends Control

@export var label: Label

func _ready() -> void:
	if GameManager.current_state.utility == 1:
		label.text = "Player won"
	else:
		label.text = "CPU won"
