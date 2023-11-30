extends Area2D
signal CanShoot(state)
var player = load("res://player.gd").new()

var speed = 100  # vitesse de déplacement de la note
var score = 0   # score du joueur

func _ready():
	position.x = 20  # position initiale de la note sur la ligne
	position.y = 51
	
func _process(delta):
	position.x += speed * delta 


