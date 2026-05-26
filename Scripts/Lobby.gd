extends Control

func _ready():
	# UI 로드 후 각 슬롯 버튼에 데이터 표시 (생략 가능)
	print("Lobby loaded. Total Currency: ", GameManager.total_currency)

func _on_slot_pressed(index: int):
	print("Slot selected: ", index)
	var slot = GameManager.slots[index]
	if not slot["is_active"]:
		print("Starting new character in slot ", index)
		GameManager.start_new_character(index)
	else:
		print("Loading existing character in slot ", index)
		GameManager.current_slot_index = index
	
	# 게임 메인 씬으로 전환
	get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")
