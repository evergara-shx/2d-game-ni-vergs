extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		get_parent().card_collected()
		queue_free()
