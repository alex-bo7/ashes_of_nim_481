extends RigidBody3D

@export var row_idx: int = -1
@export var match_stick_black: Node3D
@export var match_stick_red: Node3D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		#match_stick_red.visible = true
		#match_stick_black.visible = false
		print(row_idx)
