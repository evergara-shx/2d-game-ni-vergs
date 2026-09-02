extends Node2D

@export var required_cards: int = 3

@onready var cards = get_node("../Cards")
@onready var gate_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var barrier: CollisionShape2D = $StaticBody2D/CollisionShape2D
@onready var status_text: Label = $Label

func _ready() -> void:
	status_text.visible = false


func _process(_delta: float) -> void:
	if cards.collected_cards >= required_cards:
		gate_sprite.play("open")
		barrier.set_deferred("disabled", true)
	else:
		gate_sprite.play("closed")
		barrier.set_deferred("disabled", false)


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		status_text.visible = true
		update_text()


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		status_text.visible = false


func update_text() -> void:
	if cards.collected_cards >= required_cards:
		status_text.text = "ACCESS GRANTED"
	else:
		status_text.text = "CARDS: %d / %d" % [cards.collected_cards, required_cards]
