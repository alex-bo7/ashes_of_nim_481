extends Control

@export var turn_label: Label
@export var row_label: Label
@export var matches_label: Label
@export var confirm_btn: Button

func _ready() -> void:
	fill_labels()


func fill_labels() -> void:
	if GameManager.current_state.to_move == GameManager.turn.PLAYER:
		turn_label.text = "Player Turn: You"
	else:
		turn_label.text = "AI Turn: " # + difficulty
	
	row_label.text = "Selected Row: " + str(GameManager.current_selected_row)
	matches_label.text = "Selected Matches: " + str(GameManager.selected_matches.size())


func _on_confirm_btn_pressed() -> void:
	GameManager.player_move()
	fill_labels()
