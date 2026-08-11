extends Node2D

@export var required_cards: int = 3

@onready var cards = get_node("../Cards")
@onready var gate_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var barrier: CollisionShape2D = $StaticBody2D/CollisionShape2D

func _process(_delta: float) -> void:
	if cards.collected_cards >= required_cards:
		gate_sprite.play("open")
		barrier.set_deferred("disabled", true)
	else:
		gate_sprite.play("closed")
		barrier.set_deferred("disabled", false)
