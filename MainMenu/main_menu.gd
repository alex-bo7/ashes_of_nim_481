extends Control


func _on_play_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://NimGameScene/nin_game_scene.tscn")


func _on_settings_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Settings/settings.tscn")

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
