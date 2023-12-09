extends CharacterBody2D

class_name Player

signal weapon_switched(prev_index, new_index)
signal weapon_picked_up(weapon_texture)
signal weapon_droped(index)
@export var speed: int = 500  


var weapon_inventory = []
var equipped_weapon_index: int = 0
var current_weapon: Weapon
@onready var weapons: Node2D = get_node("Weapons")

func _ready() -> void:
	if weapons.get_child(0) != null:
		emit_signal("weapon_picked_up", weapons.get_child(0).get_texture())


func _physics_process(_delta):
	var target_position = get_global_mouse_position()
	var object_position = global_transform.origin
	var look = target_position - object_position
	if look.x <= 0:
		get_node("AnimatedSprite2D").flip_h = true
	elif look.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	#if current_weapon != null:
		#print(current_weapon.position)


func _unhandled_input(event):
	if event is InputEventMouseButton :
		var emb : InputEventMouseButton = event
		if emb.is_pressed() :
			if emb.button_index == MOUSE_BUTTON_WHEEL_UP:
				switch_weapon(MOUSE_BUTTON_WHEEL_UP)
			if emb.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				switch_weapon(MOUSE_BUTTON_WHEEL_DOWN)
			
		

# WEAPON RELATED
func switch_weapon(direction: int) -> void:
	if weapons.get_child_count() == 0 : return
	
	var prev_index: int = 0 
	var index: int = prev_index
	
	if current_weapon != null :
		prev_index = current_weapon.get_index()
		index = prev_index
		current_weapon.hide()
		
		current_weapon.equip(false)
		if direction == MOUSE_BUTTON_WHEEL_UP:
			index += 1
		else:
			index -= 1
			
		if index > weapons.get_child_count() - 1:
				index = 0
		if index < 0:
			index = weapons.get_child_count() - 1

	current_weapon = weapons.get_child(index)
	current_weapon.show()
	current_weapon.equip(true)

	emit_signal("weapon_switched", prev_index, index)

func pick_up_weapon(weapon: Node2D) -> void:
	weapon_inventory.append(weapon.duplicate())
	var new_index: int = weapons.get_child_count()
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	weapon.set_deferred("position", Vector2(0,0))
	weapon.set_deferred("offset", Vector2(250,0))
	weapon.set_deferred("z_index", 200)
	call_deferred("switch_weapon",MOUSE_BUTTON_WHEEL_DOWN)
	call_deferred("_set_up_new_weapon")
	emit_signal("weapon_picked_up", weapon.get_texture())
	emit_signal("weapon_switched", equipped_weapon_index, new_index)

func _set_up_new_weapon():
	var hud : HUD = get_node("HUD")
	hud.CanShoot.connect(current_weapon._on_can_shoot)

func _drop_weapon() -> void:
	weapon_inventory.remove_at(current_weapon.get_index() - 1)
	var weapon_to_drop: Node2D = current_weapon
	switch_weapon(MOUSE_BUTTON_WHEEL_DOWN)

	emit_signal("weapon_droped", weapon_to_drop.get_index())

	weapons.call_deferred("remove_child", weapon_to_drop)
	get_tree().call_deferred("add_child", weapon_to_drop)
	weapon_to_drop.set_owner(get_parent())
	await weapon_to_drop.tree_entered
	weapon_to_drop.show()
