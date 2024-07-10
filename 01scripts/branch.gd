extends Area2D
class_name Branch

@onready var collision_polygon_2d : CollisionPolygon2D = $CollisionPolygon2D
@onready var polygon_2d : Polygon2D = $branch01

func _ready():
	collision_polygon_2d.polygon = polygon_2d.polygon
	
