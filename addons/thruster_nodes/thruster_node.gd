extends Node
var internal_mesh : ImmediateMesh = ImmediateMesh.new()
var m = StandardMaterial3D.new()

@export var thickness = 0.01
@export var height = 0.1
@export var thrust = 1

@export var roll_factor : bool = true
@export var pitch_factor : bool = true
@export var yaw_factor : bool = true

@export var vertical_factor : bool = true
@export var forward_factor : bool = true
@export var lateral_factor : bool = true

# keeps track of transform changes to update motors matrix
var last_transform

func get_class():
	return "Thruster"

func _ready():
	last_transform = 0
	if Engine.is_editor_hint():
		m.flags_unshaded = true
		m.albedo_color = Color(1.0, 1.0, 1.0, 0.8)
		m.depth_enabled = false
		m.render_priority = m.RENDER_PRIORITY_MAX
		m.flags_no_depth_test = true
# TODO
		#set_material_override(m)

func _process(_delta):
	
	#TODO
	#if last_transform != transform:
		#get_parent().calculate_motors_matrix()
		#last_transform = transform

	internal_mesh.clear_surfaces()

	# Begin draw.
	internal_mesh.surface_begin(Mesh.PRIMITIVE_LINES)

	# base
	internal_mesh.surface_add_vertex(Vector3(0, -thickness, -thickness))
	internal_mesh.surface_add_vertex(Vector3(0, -thickness, thickness))

	internal_mesh.surface_add_vertex(Vector3(0, -thickness, thickness))
	internal_mesh.surface_add_vertex(Vector3(0, thickness, thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0, thickness, thickness))
	internal_mesh.surface_add_vertex(Vector3(0, thickness, -thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0, thickness, -thickness))
	internal_mesh.surface_add_vertex(Vector3(0, -thickness, -thickness))

	# walls
	internal_mesh.surface_add_vertex(Vector3(0, -thickness, -thickness))
	internal_mesh.surface_add_vertex(Vector3(height, -thickness, -thickness))

	internal_mesh.surface_add_vertex(Vector3(0, -thickness, thickness))
	internal_mesh.surface_add_vertex(Vector3(height, -thickness, thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0, thickness, thickness))
	internal_mesh.surface_add_vertex(Vector3(height, thickness, thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0, thickness, -thickness))
	internal_mesh.surface_add_vertex(Vector3(height, thickness, -thickness))

	# Hat
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*-thickness, 1.3*-thickness))
	internal_mesh.surface_add_vertex(Vector3(1.5*height, 0, 0))
	
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*thickness, 1.3*-thickness))
	internal_mesh.surface_add_vertex(Vector3(1.5*height, 0, 0))
	
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*thickness, 1.3*thickness))
	internal_mesh.surface_add_vertex(Vector3(1.5*height, 0, 0))
	
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*-thickness, 1.3*thickness))
	internal_mesh.surface_add_vertex(Vector3(1.5*height, 0, 0))

	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*-thickness, 1.3*-thickness))
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*thickness, 1.3*-thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*thickness, 1.3*-thickness))
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*thickness, 1.3*thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*thickness, 1.3*thickness))
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*-thickness, 1.3*thickness))
	
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*-thickness, 1.3*thickness))
	internal_mesh.surface_add_vertex(Vector3(0.9 * height, 1.3*-thickness, 1.3*-thickness))
	# End drawing.
	internal_mesh.surface_end()

