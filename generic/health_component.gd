extends Node2D

class_name HealthComponent

@export var MAX_HEALT := 10.0
var health : float

func _ready():
	health = MAX_HEALT

func damage(attack: Attack):
	health -= attack.attack_damage
	$AudioStreamPlayer2D.play()
	
	if health <= 0:
		get_parent().queue_free()
