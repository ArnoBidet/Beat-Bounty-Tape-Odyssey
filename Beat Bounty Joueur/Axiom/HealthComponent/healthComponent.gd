extends Node2D
class_name HealthComponent
@export var max_health : int = 100
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func damage():
	if health <= 0:
		get_parent().queue_free()
