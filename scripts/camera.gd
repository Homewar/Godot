extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zoom()

func zoom():
	if Input.is_action_just_pressed("wheel_down") and get_zoom() > Vector2(1,1):
		set_zoom(get_zoom() - Vector2(0.25, 0.25))
	if Input.is_action_just_pressed("wheel_up"): #and get_zoom() > Vector2.ONE:
		set_zoom(get_zoom() + Vector2(0.25, 0.25))
