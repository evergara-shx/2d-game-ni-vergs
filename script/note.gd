extends Area2D

@export_multiline var note_text: String = "This is a note."

@onready var note_display = $CanvasLayer/NoteDisplay
@onready var note_text_label = $CanvasLayer/NoteDisplay/NoteText

func _ready():
	note_display.visible = false
	note_text_label.text = note_text

func _on_body_entered(body):
	if body.is_in_group("player"):
		note_display.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		note_display.visible = false
