extends CanvasLayer

signal intro_finished

@export var level_title: String = ""
@export_multiline var level_description: String = ""

@onready var level_name: Label = $CenterContainer/Panel/LevelName
@onready var description: Label = $CenterContainer/Panel/Description
@onready var panel: TextureRect = $CenterContainer/Panel

func _ready():
	level_name.text = level_title
	description.text = level_description

	panel.modulate.a = 0.0

	var tween = create_tween()

	tween.tween_property(panel, "modulate:a", 1.0, 0.8)
	tween.tween_interval(2.5)
	tween.tween_property(panel, "modulate:a", 0.0, 1.0)

	await tween.finished
	
	intro_finished.emit()
	queue_free()
