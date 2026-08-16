extends Node2D

@export var objective_text: String = ""

@onready var level_intro = $LevelIntro
@onready var objective_ui = $ObjectiveUI


func _ready() -> void:
	level_intro.intro_finished.connect(_on_intro_finished)


func _on_intro_finished() -> void:
	objective_ui.set_objective(objective_text)
	objective_ui.show_objective()
