extends CharacterBody2D
class_name Enemy

const SPEED = 80.0
var hp: int = 30
var attack_power: int = 5

@onready var player = get_node_or_null("/root/Lobby/Player") # 임시로 로비 안의 플레이어 참조

func _physics_process(delta):
	if player and is_instance_valid(player):
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * SPEED
		move_and_slide()
		
		# 간단한 충돌 데미지 로직 (나중에 Area2D Hitbox로 교체 권장)
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			if collision.get_collider() is Player:
				collision.get_collider().take_damage(attack_power)

func take_damage(amount: int):
	hp -= amount
	if hp <= 0:
		die()

func die():
	print("Enemy defeated!")
	# 아이템 드랍 로직 호출
	drop_items()
	queue_free()

var item_scene = preload("res://Scenes/Item.tscn")

func drop_items():
	var roll = randf()
	var item_instance = item_scene.instantiate()
	item_instance.global_position = global_position
	
	if roll < 0.2:
		item_instance.type = 0 # WEAPON
	elif roll < 0.4:
		item_instance.type = 1 # ARMOR
	else:
		item_instance.type = 2 # CURRENCY
		
	get_parent().add_child(item_instance)
