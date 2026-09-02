extends Area2D

@export_file("*.tscn") var next_level: String

@onready var transition = $"../transition"

func _on_body_entered(body):
	if body is CharacterBody2D:
		print("PORTAL TOUCHED")
		transition.fade_to_scene(next_level)
