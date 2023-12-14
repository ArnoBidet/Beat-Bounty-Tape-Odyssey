extends Weapon

class_name RangeWeapon

@export var bullet : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot():
	var bullet_instance = bullet.instantiate()
	get_tree().get_root().add_child(bullet_instance)
	bullet_instance.rotation = self.rotation + PI/2
	bullet_instance.global_position = self.global_position
	apply_recoil()
	$AudioStreamPlayer2D.play()

func apply_recoil():
	var tween = get_tree().create_tween()
	var recoil_strength = 50  # Adjust the strength of the recoil
	var recoil_duration = 0.05  # Adjust the duration of the recoil

	tween.tween_property($weapon_outlet, "position", Vector2(-recoil_strength,0), recoil_duration)
	tween.tween_property($weapon_outlet, "position", Vector2(0,0), recoil_duration)


func _unhandled_input(event):
	if event.is_action_pressed("click") :
		if canShoot && equiped :
			shoot()
		HasShot.emit()
