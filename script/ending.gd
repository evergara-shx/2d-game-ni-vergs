extends Node2D

@onready var control_room = $ControlRoom
@onready var city = $City
@onready var text = $Text
@onready var fade = $CanvasLayer/Fade

var fade_time := 1.0
var scene_time := 4.0


func _ready():
	control_room.visible = true
	city.visible = false

	# Start completely black
	fade.color.a = 1.0

	text.text = "The control room fell silent."

	# Fade into Control Room
	await fade_to(0.0)

	await get_tree().create_timer(scene_time).timeout

	# Fade to black
	await fade_to(1.0)

	# Change to City
	control_room.visible = false
	city.visible = true

	text.text = "Veyra was left behind."

	# Fade into City
	await fade_to(0.0)

	await get_tree().create_timer(scene_time).timeout

	# Fade to black
	await fade_to(1.0)

	# Final text on black screen
	text.text = "And whatever remained beneath it... stayed buried."

	await fade_to(0.0)

	await get_tree().create_timer(4.0).timeout

	# Final fade to black
	await fade_to(1.0)

	# Return to Main Menu
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")


func fade_to(alpha: float):
	var tween = create_tween()
	tween.tween_property(
		fade,
		"color:a",
		alpha,
		fade_time
	)

	await tween.finished
