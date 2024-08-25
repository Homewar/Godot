extends Node

@export var player_pos: Vector2

func x_axis_angle(direction_1: Vector2,direction_2: Vector2):
	#direction_1 начало вектора для которого ищется угол
	#direction_2 конец вектора для которого ищется угол
	#поворот осуществляется от оси x где Ox угол в  0 градусов
	var direction_3 = direction_2 - direction_1 
	var radian = atan2(direction_3.y,direction_3.x)
	var angle = radian*180/PI
	
	if angle < 0:
		angle += 360
		
	return angle 

func add_distance(position: Vector2, distance: int):
	var x = position.x
	var y = position.y
	
	if x >= 0 and y >= 0:
		return Vector2(x+distance,y+distance)
	if x < 0 and y < 0:
		return Vector2(x-distance,y-distance)
	if x >= 0 and y < 0:
		return Vector2(x+distance,y-distance)
	if x < 0 and y >= 0:
		return Vector2(x-distance,y+distance)
