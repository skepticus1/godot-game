extends RemoteTransform2D


func _ready():
	# delay connection until scene is setup
	await get_tree().process_frame
	
	# get the camera2d in the dungeon
	var camera = get_tree().root.get_node("Dungeon-01/Camera2D")

	# connect to remotetransform2d to camera
	self.remote_path = camera.get_path()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
