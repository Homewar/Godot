extends Node2D

@onready var character = get_parent()
@onready var projectile = load("res://scenes/projectile.tscn")

func _process(delta):
	if Input.is_action_just_pressed("Fire"):
		shoot()
	rotation_degrees = Global.x_axis_angle(Global.player_pos,get_global_mouse_position()) + 90

func shoot():
	var instance = projectile.instantiate()
	instance.dir = rotation
	instance.spawnPos = Global.player_pos
	instance.spawnRot = rotation
	#instance.Player = 
	character.add_child.call_deferred(instance)
