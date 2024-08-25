extends Node2D

var character = load("res://scenes/character.tscn")
var target = load("res://scenes/node_2d.tscn")

@onready var tileMap = $TileMap

var height = 100
var width = 100
var cell_position
var birth_limit = 4 #default 4
var death_limit = 3 #default 3
var steps = 4 		#default 4

var map = []


# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = character.instantiate()
	add_child(instance)
	#map_gen_filling()
	map_gen_filling()
	generate_map()
	for i in range(steps):
		map = simulate_step()
	draw_map()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func map_gen_filling(): #заполняем карту для клеточного автомата
	var positions = []
	for i in range(height):
		for j in range(width):
			cell_position = Vector2i(j, i)
			positions.append(cell_position)
	tileMap.set_cells_terrain_connect(0, positions, 0, 1, true)

func generate_map():
	map.resize(height)
	for i in range(height):
		map[i] = []
		for j in range(width):
			# Инициализация случайной карты: 1 - стена, 0 - пустота
			if randf() < 0.45:
				map[i].append(1)
			else:
				map[i].append(0)

func simulate_step():
	var new_map = []
	new_map.resize(height)
	for i in range(height):
		new_map[i] = []
		for j in range(width):
			var neighbors = count_alive_neighbors(i, j)
			if map[i][j] == 1:
				if neighbors < death_limit:
					new_map[i].append(0)
				else:
					new_map[i].append(1)
			else:
				if neighbors > birth_limit:
					new_map[i].append(1)
				else:
					new_map[i].append(0)
	return new_map

# Подсчет живых соседей вокруг ячейки
func count_alive_neighbors(x, y):
	var count = 0
	for i in range(-1, 2):
		for j in range(-1, 2):
			var nx = x + i
			var ny = y + j
			if i == 0 and j == 0:
				continue
			elif nx < 0 or ny < 0 or nx >= height or ny >= width:
				count += 1
			elif map[nx][ny] == 1:
				count += 1
	return count

# Отрисовка карты
func draw_map():
	var positions = []
	for i in range(height):
		for j in range(width):
			if map[i][j] == 1:
				positions.append(Vector2i(j, i))
				
	#(int layer, Vector2i[] cells, int terrain_set, int terrain, bool ignore_empty_terrains=true )
	tileMap.set_cells_terrain_connect(0, positions, 1, 0)
	tileMap.set_cells_terrain_connect(1, positions, 1, 1)
