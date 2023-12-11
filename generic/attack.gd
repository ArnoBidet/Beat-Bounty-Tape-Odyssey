extends Area2D

class_name Attack

@export var attack_damage : int


func _on_area_entered(area):
	if area is HitboxComponent:
		area.damage(self)


func _on_area_exited(area):
	pass # Replace with function body.
