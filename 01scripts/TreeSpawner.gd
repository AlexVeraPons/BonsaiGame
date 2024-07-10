extends Node2D
class_name TreeSpawner

var _branch_segments : Array[BranchSegment]

func _ready():
	var points := [
		Vector2(0, 0),
		Vector2(100, 0),
		Vector2(100, 100),
		Vector2(0, 100)
	]
	
	var polygon := PolygonCreator.create_polygon(points)
	polygon.rotate(10)
	_add_branch(polygon)
	_new_branch_from_branch(_branch_segments[0])

func _grow() -> void:
	for segment in _branch_segments:
		#Create a new branch from this
		pass
	
func _add_branch(polygon :Polygon2D) -> void:
	add_child(polygon)
	var new_segment = BranchSegment.new()
	new_segment.polygon = polygon
	_branch_segments.append(new_segment)
	
func _new_branch_from_branch(branch : BranchSegment) -> void:
	# first we need the normals from all the edges
	# then we need to see which of the normals will get us a positive position
	# finally we create a smaller branch from that one
	var edges := PolygonCreator.get_polygon_edges(branch.polygon.polygon)
	var normals : Array
	for edge in edges:
		var normal : Vector2 = edge.get_normal()
		if normal.x > 0 and normal.y < 0:
			 # Calculate the midpoint of the edge
			var mid_point = (edge.start_vertex + edge.end_vertex) / 2
			
			# Determine the new position for the smaller polygon
			var new_position = mid_point + normal# Adjust the scale factor as needed
			
			# Create a new smaller polygon
			var points =[ 
				Vector2(0, 0),
				Vector2(90, 0),
				Vector2(90, 90),
				Vector2(0, 90),
			]
			var angle = (atan2(normal.y, normal.x))

class BranchSegment:
	var polygon : Polygon2D
	
