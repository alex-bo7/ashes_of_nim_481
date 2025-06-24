extends Control

@export var turn_label: Label
@export var row_label: Label
@export var matches_label: Label
@export var confirm_btn: Button
@export var panel: Panel

const GREEN: String = "#06d6a0" #06d6a0
const RED: String = "#ef476f"

var stylebox: StyleBoxFlat = get_theme_stylebox("panel")

func _ready() -> void:
	update_gui()


func change_label(new_text:String, new_color:String) -> void:
	turn_label.text = new_text
	turn_label.add_theme_color_override("font_color", new_color)


func change_panel(new_color:String) -> void:
	stylebox.set_border_width_all(6)
	stylebox.border_color = Color(new_color)
	panel.add_theme_stylebox_override("panel", stylebox)


func update_gui() -> void:
	if GameManager.current_state.to_move == GameManager.turn.PLAYER:
		change_label("Player Turn", GREEN)
		change_panel(GREEN)
	else:
		change_label("AI Turn", RED)
		change_panel(RED)
	
	row_label.text = "Selected Row: " + str(GameManager.selected_row)
	matches_label.text = "Selected Matches: " + str(GameManager.selected_matches.size())


func _on_confirm_btn_pressed() -> void:
	GameManager.player_move()
	update_gui()
	
	# wait for ai turn, ai timer is 0.5
	if not GameManager.nim.terminal_test(GameManager.current_state):
		await get_tree().create_timer(0.8).timeout
		update_gui()
