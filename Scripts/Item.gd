extends Area2D
class_name Item

enum ItemType { WEAPON, ARMOR, CURRENCY }
var type: ItemType = ItemType.WEAPON

func _ready():
	# 노란색으로 보이게 (임시)
	modulate = Color(1, 1, 0)

func _on_body_entered(body):
	if body is Player:
		if type == ItemType.WEAPON:
			body.attack_power += 5
			print("Weapon acquired! Attack: ", body.attack_power)
		elif type == ItemType.ARMOR:
			body.defense += 2
			print("Armor acquired! Defense: ", body.defense)
		else:
			GameManager.total_currency += 10
			print("Currency acquired! Total: ", GameManager.total_currency)
		
		queue_free()
