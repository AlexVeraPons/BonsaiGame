class_name MyLine

var start_vertex := Vector2(0,0)
var end_vertex := Vector2(0,0)

func _init(start : Vector2, end : Vector2):
	start_vertex = start
	end_vertex = end
	
func get_normal() -> Vector2:
	var direction = start_vertex - end_vertex
	direction = direction.normalized()
	var normal = Vector2(-direction.y, direction.x)
	return normal

func get_normal_line2D(normal : Vector2) -> Node2D:
	var node = Node2D.new()
	var mid_point = (start_vertex + end_vertex) / 2
		
	var normal_start = mid_point
	var normal_end = mid_point + normal *50
		
	var child_line = Line2D.new()
	child_line.add_point(normal_start )
	child_line.add_point(normal_end)
	child_line.default_color = Color.RED 
		
	#Creating a label to showcase the position
	var label = Label.new()
	label.text = str(normal.x) + "," + str(normal.y)
	label.position =  Vector2(normal_end.x+10, normal_end.y + 10)
	node.add_child(label)
	node.add_child(child_line)
	return node
