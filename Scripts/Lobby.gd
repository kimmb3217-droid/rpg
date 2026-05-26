extends Control

func _ready():
	print("Lobby loaded. Total Currency: ", GameManager.total_currency)

func _process_slot(index: int):
	print("Slot selected: ", index)
	var slot = GameManager.slots[index]
	if not slot["is_active"]:
		print("Starting new character in slot ", index)
		GameManager.start_new_character(index)
	else:
		print("Loading existing character in slot ", index)
		GameManager.current_slot_index = index
	
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")

func _on_slot_0_pressed(): _process_slot(0)
func _on_slot_1_pressed(): _process_slot(1)
func _on_slot_2_pressed(): _process_slot(2)
func _on_slot_3_pressed(): _process_slot(3)
func _on_slot_4_pressed(): _process_slot(4)
