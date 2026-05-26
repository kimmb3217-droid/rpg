extends CanvasLayer

@onready var cost_label = $Panel/CostLabel
var revive_cost: int = 50

func _ready():
	cost_label.text = "Revive Cost: " + str(revive_cost) + " Currency"

func _on_revive_pressed():
	if GameManager.revive_player(revive_cost):
		print("Player Revived!")
		# 게임 재시작 또는 체력 복구 로직
		get_tree().change_scene_to_file("res://Scenes/MainLevel.tscn")
	else:
		print("Not enough currency!")
		$Panel/CostLabel.text = "Not enough Currency!"
		$Panel/CostLabel.modulate = Color(1, 0, 0)

func _on_give_up_pressed():
	print("Given up. Slot reset.")
	GameManager.reset_current_slot()
	get_tree().change_scene_to_file("res://Scenes/Lobby.tscn")
