extends CanvasLayer

@onready var fade = $Fade

func _ready():
	fade.modulate.a = 0.0

func fade_to_scene(scene_path: String):
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, 1.0)
	await tween.finished
	
	get_tree().change_scene_to_file(scene_path)
