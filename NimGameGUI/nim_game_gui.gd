extends Control

@export var turn_label: Label
@export var row_label: Label
@export var matches_label: Label
@export var confirm_btn: Button
@export var panel: Panel

var stylebox: StyleBoxFlat = get_theme_stylebox("panel")

func _ready() -> void:
	update_gui()


func update_gui() -> void:
	stylebox.set_border_width_all(4)
	
	if GameManager.current_state.to_move == GameManager.turn.PLAYER:
		turn_label.text = "Player Turn"
		stylebox.border_color = Color.GREEN
		panel.add_theme_stylebox_override("panel", stylebox)
	else:
		turn_label.text = "AI Turn"
		stylebox.border_color = Color.RED
		panel.add_theme_stylebox_override("panel", stylebox) 
	
	row_label.text = "Selected Row: " + str(GameManager.selected_row)
	matches_label.text = "Selected Matches: " + str(GameManager.selected_matches.size())


func _on_confirm_btn_pressed() -> void:
	GameManager.player_move()
	update_gui()
	
	# wait for ai turn, ai timer is 0.5
	await get_tree().create_timer(0.8).timeout
	update_gui()
