extends Control


func _on_play_btn_pressed() -> void:
	print('Play')


func _on_settings_btn_pressed() -> void:
	print('Settings')

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
