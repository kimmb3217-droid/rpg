extends CanvasLayer

@onready var hp_label = $MarginContainer/VBoxContainer/HPLabel
@onready var currency_label = $MarginContainer/VBoxContainer/CurrencyLabel

func _process(delta):
	# 매 프레임 업데이트 (단순화)
	if GameManager.current_slot_index != -1:
		var slot = GameManager.slots[GameManager.current_slot_index]
		var hp = slot.get("hp", 0)
		var max_hp = slot.get("max_hp", 0)
		
		# 플레이어 노드 직접 참조가 더 정확하지만 프로토타입 편의상 GameManager 의존
		# 실제 게임에서는 Player 노드에 signal을 연결하는 것이 좋습니다.
		
		# 현재 씬에 Player가 있다면 Player의 실시간 체력을 가져옴
		var player = get_node_or_null("/root/MainLevel/Player")
		if player:
			hp = player.hp
			max_hp = player.max_hp
			
		hp_label.text = "HP: " + str(hp) + " / " + str(max_hp)
	
	currency_label.text = "Currency: " + str(GameManager.total_currency)
