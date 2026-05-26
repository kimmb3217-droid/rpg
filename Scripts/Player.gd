extends CharacterBody2D
class_name Player

const SPEED = 150.0

var hp: int = 100
var max_hp: int = 100
var attack_power: int = 10
var defense: int = 5

func _ready():
	_load_stats_from_manager()

func _load_stats_from_manager():
	if GameManager.current_slot_index != -1:
		var data = GameManager.slots[GameManager.current_slot_index]
		hp = data.get("hp", 100)
		max_hp = data.get("max_hp", 100)
		attack_power = data.get("attack", 10)
		defense = data.get("defense", 5)

func _physics_process(delta):
	# 모바일 가상 조이스틱이나 키보드 방향키 입력을 받습니다.
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		attack()

func attack():
	print("Player attacks with power: ", attack_power)
	# 공격 로직 (추후 Hitbox 연동)

func take_damage(amount: int):
	var actual_damage = max(1, amount - defense)
	hp -= actual_damage
	if hp <= 0:
		die()

func die():
	print("Player died!")
	GameManager.on_player_died()
