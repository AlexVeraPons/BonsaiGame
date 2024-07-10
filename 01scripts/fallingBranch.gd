extends RigidBody2D
class_name FallingBranch

@onready var polygon_2d : Polygon2D = $Polygon2D
@export var time_to_disappear := 1.0

var directional_velocity := 400.00
var rotational_velocity := 20.00
var time_passed := 0.0

func _ready():
	var rand_dir_velocity := randf_range(-directional_velocity,directional_velocity)
	var rand_rot_velocuty := randf_range(-rotational_velocity,rotational_velocity)
	self.set_axis_velocity(Vector2(rand_dir_velocity,0))
	angular_velocity = rand_rot_velocuty
	
func _process(delta):
	time_passed += delta
	var color_alpha :float = lerpf(1,0,time_passed/time_to_disappear)
	var new_color = Color(polygon_2d.color,color_alpha)
	set_polygon_color(new_color)

func set_polygon(polygon :PackedVector2Array) -> void:
	if not polygon_2d:
		polygon_2d = $Polygon2D
	polygon_2d.polygon = polygon
	polygon_2d = PolygonCreator.center_polygon(polygon_2d)
	
func set_polygon_color(color : Color) -> void:
	if not polygon_2d:
		polygon_2d = $Polygon2D
	polygon_2d.color = color
