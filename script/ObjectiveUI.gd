extends CanvasLayer

@export var Objective: String = ""
@export_multiline var obj: String = ""

@onready var objective: Label = $CenterContainer/Panel/objective
@onready var objective_description: Label = $CenterContainer/Panel/Objective_description
@onready var center_container: CenterContainer = $CenterContainer


func _ready() -> void:
	center_container.modulate.a = 0.0
	objective.text = "OBJECTIVE: " + Objective
	objective_description.text = obj


func set_objective(text: String) -> void:
	objective.text = "OBJECTIVE: " + text


func show_objective() -> void:
	var tween = create_tween()
	tween.tween_property(center_container, "modulate:a", 1.0, 0.6)


func hide_objective() -> void:
	var tween = create_tween()
	tween.tween_property(center_container, "modulate:a", 0.0, 0.4)
