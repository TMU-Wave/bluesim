extends SubViewportContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var sonar = null
var img = Image.new()
var last_points = []
var angle = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_ping360_update(pingAngle, points):
	self.last_points = points
	self.angle = pingAngle


# Called when the node enters the scene tree for the first time.
func _ready():
	var sonars = get_tree().get_nodes_in_group("ping360")
	if len(sonars) == 0:
		print("unable to find ping360")
		return
	self.sonar = sonars[0]
	self.sonar.connect("updatePing360Display", Callable(self, "on_ping360_update"))

	# You'll have to get thoose the way you want
	var array_width = 100
	var array_heigh = 360
	var array = []
	for _y in range(360):
		for _x in range(100):
			array.append(0)

	# The following is used to convert the array into a Texture
	var byte_array = PackedByteArray(array)

	# I don't want any mipmaps generated : use_mipmaps = false
	# I'm only interested with 1 component per pixel (the corresponding array value) : Format = Image.FORMAT_R8
	img.create_from_data(array_width, array_heigh, false, Image.FORMAT_R8, byte_array)


func _process(_delta):
	visible = Globals.ping360_enabled
	false # img.lock() # TODOConverter3To4, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	for x in range(100):
		img.set_pixel(x, angle, 0)
	for point in last_points:
		var distance = point[0]
		var intensity = point[1]
		img.set_pixel(int(distance), angle, Color(intensity, intensity, intensity))

	false # img.unlock() # TODOConverter3To4, Image no longer requires locking, `false` helps to not break one line if/else, so it can freely be removed
	#var image = texture.get_data()
	#img.set_pixel(angle, angle, 6)
	# Override the default flag with 0 since I don't want texture repeat/filtering/mipmaps/etc
	var texture = ImageTexture.new()
	texture.create_from_image(img) #,0
	# Upload the texture to my shader
	self.get_material().set_shader_parameter("my_array", texture)


func _on_Ping360Toggle_toggled(button_pressed):
	Globals.ping360_enabled = button_pressed
