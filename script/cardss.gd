extends Node

var collected_cards: int = 0

func card_collected() -> void:
	collected_cards += 1
	print("Cards: ", collected_cards)
