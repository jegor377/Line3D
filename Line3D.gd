tool
extends ImmediateGeometry

export(Vector3) var end_point = Vector3.ONE
export(float) var width = 1.0
export(NodePath) var p

func transform_pos(pos: Vector3) -> Vector3:
	var d = end_point.length()
	var t := Transform()
	t = t.scaled(Vector3(width, 1, d))
	t = t.looking_at(end_point, Vector3.UP)
	t = t.scaled(-Vector3.ONE)
	t.basis.z *= d
	t.basis.x *= width
	return pos.x * t.basis.x + pos.y * t.basis.y + pos.z * t.basis.z

func _process(delta):
	if p != '':
		end_point = get_node(p).transform.origin
	# Clean up before drawing.
	clear()
	
	# Begin draw.
	begin(Mesh.PRIMITIVE_TRIANGLE_STRIP, null)

	# Prepare attributes for add_vertex.
	set_normal(Vector3(0, 1, 0))
	set_uv(Vector2(0, 1))
	# Call last for each vertex, adds the above attributes.
	#add_vertex(Vector3(-1, 0, -1))
	add_vertex(transform_pos(Vector3(-1, 0, 0)))

	set_normal(Vector3(0, 1, 0))
	set_uv(Vector2(1, 1))
	#add_vertex(Vector3(1 * end_point.x, 0, -1))
	add_vertex(transform_pos(Vector3(1, 0, 0)))

	set_normal(Vector3(0, 1, 0))
	set_uv(Vector2(0, 0))
	#add_vertex(Vector3(-1, 0, 1))
	add_vertex(transform_pos(Vector3(-1, 0, 1)))

	set_normal(Vector3(0, 1, 0))
	set_uv(Vector2(1, 0))
	#add_vertex(Vector3(1 * end_point.x, 0, 1))
	add_vertex(transform_pos(Vector3(1, 0, 1)))

	# End drawing.
	end()
