class_name PolygonCreator

static func create_polygon (points : Array) -> Polygon2D:
  # Creating a basic polygon on instance
	var polygon_to_return := Polygon2D.new()
	polygon_to_return.polygon = PackedVector2Array(points)
	polygon_to_return.color = Color.WHITE
	return polygon_to_return

static func get_polygon_edges(polygon: Array) -> Array[MyLine]:
	var edges : Array[MyLine]
	var vertex_count = polygon.size()

	for i in range(vertex_count):
		var start_vertex = polygon[i]
		var end_vertex = polygon[(i + 1) % vertex_count] # Connect last vertex back to first
		var line = MyLine.new(start_vertex,end_vertex)
		edges.append(line)
		
	return edges

static func print_polygon (polyogn_to_print : PackedVector2Array, name : String = "default") ->void:
	var points_str = ""
	for point in polyogn_to_print:
		points_str += str(point) + " "
	points_str += name
	print(points_str.strip_edges())
	
static func rotate_polygon(polygon: PackedVector2Array, angle: float) -> PackedVector2Array:
	var rotated_polygon = PackedVector2Array()
	var cos_angle = cos(angle)
	var sin_angle = sin(angle)

	# Assuming the bottom center of the rectangle is at (0, 0)
	var center = Vector2(0, -polygon[1].y / 2)  # polygon[1].y should give the height if vertices are ordered accordingly

	for point in polygon:
		var translated_point = point - center
		var rotated_point = Vector2(
			translated_point.x * cos_angle - translated_point.y * sin_angle,
			translated_point.x * sin_angle + translated_point.y * cos_angle
		)
		rotated_polygon.append(rotated_point + center)
	
	return rotated_polygon

static func center_polygon(polygon_2d :Polygon2D):
	if polygon_2d and polygon_2d.polygon.size() > 0:
		var centroid = Vector2()
		var polygon = polygon_2d.polygon
		
		# Calculate the centroid
		for point in polygon:
			centroid += point
		centroid /= polygon.size()
		
		# Translate points to center around the origin
		var centered_polygon = PackedVector2Array()
		for point in polygon:
			centered_polygon.append(point - centroid)
		
		# Update the polygon points
		polygon_2d.polygon = centered_polygon
	else:
		print("Polygon2D node is null or has no points")

