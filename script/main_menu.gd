extends Control

@onready var transition = $transition

func _on_play_pressed() -> void:
	transition.fade_to_scene("res://scenes/game.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
