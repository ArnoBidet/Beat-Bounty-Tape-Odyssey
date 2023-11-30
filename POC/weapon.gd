extends AnimatedSprite2D


var init_scale = scale
func _physics_process(delta):
	look_at(get_global_mouse_position())
	var target_position = get_global_mouse_position()
	var object_position = global_transform.origin
	var look = target_position - object_position
	if look.x <= 0:
		set_scale(Vector2(init_scale.x,-init_scale.y))
	elif look.x > 0 :
		set_scale(Vector2(init_scale.x,init_scale.y))
