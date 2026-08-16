extends CanvasLayer

signal intro_finished

@export var level_title: String = ""
@export_multiline var level_description: String = ""

# Type the exact name of the design you want to use.
# Example: "CenterContainer" or "CenterContainer2"
@export var design_name: String = "CenterContainer"


func _ready() -> void:
	# Hide every design except the selected one.
	var active_design: Control = null

	for child in get_children():
		if child is Control:
			if child.name == design_name:
				child.show()
				active_design = child
			else:
				child.hide()

	# Make sure the selected design actually exists.
	if active_design == null:
		push_error("LevelIntro: Design '%s' was not found!" % design_name)
		intro_finished.emit()
		queue_free()
		return

	# Find the elements inside the selected design.
	var panel: Control = active_design.get_node("Panel")
	var level_name: Label = active_design.get_node("Panel/LevelName")
	var description: Label = active_design.get_node("Panel/Description")

	# Set text.
	level_name.text = level_title
	description.text = level_description

	# Start invisible.
	panel.modulate.a = 0.0

	# Play intro animation.
	var tween = create_tween()

	tween.tween_property(panel, "modulate:a", 1.0, 0.8)
	tween.tween_interval(2.5)
	tween.tween_property(panel, "modulate:a", 0.0, 1.0)

	await tween.finished

	# Tell next_level.gd that the intro is finished.
	intro_finished.emit()

	# Remove the intro.
	queue_free()
