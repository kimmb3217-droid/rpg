extends Node

const SAVE_PATH = "user://save_data.json"

# 전체 게임의 상태와 데이터를 관리합니다.
var current_slot_index: int = -1
var total_currency: int = 0

# 5개의 캐릭터 슬롯 (빈 슬롯은 null 혹은 초기화 데이터)
var slots: Array = []

func _ready():
	_init_slots()
	load_game()

func _init_slots():
	slots.clear()
	for i in range(5):
		slots.append(get_default_slot_data())

func get_default_slot_data() -> Dictionary:
	return {
		"is_active": false,
		"level": 1,
		"hp": 100,
		"max_hp": 100,
		"attack": 10,
		"defense": 5,
		"weapon": "",
		"armor": ""
	}

# 새 캐릭터 슬롯 선택 시 초기화
func start_new_character(slot_index: int):
	current_slot_index = slot_index
	slots[current_slot_index] = get_default_slot_data()
	slots[current_slot_index]["is_active"] = true
	save_game()

# 사망 시 호출
func on_player_died():
	get_tree().change_scene_to_file("res://Scenes/DeathUI.tscn")

# 부활 처리
func revive_player(cost: int):
	if total_currency >= cost:
		total_currency -= cost
		# 현재 체력만 복구 (장비, 레벨 유지)
		slots[current_slot_index]["hp"] = slots[current_slot_index]["max_hp"]
		save_game()
		return true
	return false

# 부활 포기 및 슬롯 완전 초기화
func reset_current_slot():
	if current_slot_index != -1:
		slots[current_slot_index] = get_default_slot_data()
		save_game()

func save_game():
	var save_dict = {
		"total_currency": total_currency,
		"slots": slots
	}
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_line(JSON.stringify(save_dict))

func load_game():
	if FileAccess.file_exists(SAVE_PATH):
		var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var content = file.get_as_text()
			var json = JSON.new()
			var error = json.parse(content)
			if error == OK:
				var data = json.data
				total_currency = data.get("total_currency", 0)
				slots = data.get("slots", slots)
