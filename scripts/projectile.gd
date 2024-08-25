extends CharacterBody2D

var dir: float
var spawnPos: Vector2
var spawnRot: float
var Player: Node
var zdir: int

@export var SPEED = 300.0

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	z_index = zdir 
	
func _physics_process(delta):
	velocity = Vector2(0,-SPEED).rotated(dir)
	move_and_slide()



func _on_area_2d_body_entered(body):
	if body.name != "Player":
		print(body.name)
		queue_free()


func _on_life_timeout():
	queue_free()
