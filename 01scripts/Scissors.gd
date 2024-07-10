extends Node2D
class_name Scissors

@onready var polygon_2d : Polygon2D = $Polygon2D
@onready var animation_player = $AnimationPlayer
@export var rotation_speed := 1.0

const BROKEN_BRANCH := preload("res://scenes/fallingBranch.tscn")

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _input(event) -> void:
	if event.is_action_pressed("Cut"):
		_cut()
	if event is InputEventMouseMotion:
		self.position = get_global_mouse_position()

func _process(delta) -> void:
	if Input.is_action_pressed("RotateRight"):
		_rotate_right(delta)
	if Input.is_action_pressed("RotateLeft"):
		_rotate_left(delta)

func _cut() -> void:
	animation_player.play("cut_animation")
	
	var polygon2D_in_scene : Array
	Utility.find_by_class(get_tree().current_scene,"Polygon2D",polygon2D_in_scene)
	if polygon2D_in_scene.has(get_child(0)):
		polygon2D_in_scene.erase(get_child(0))
		
	var scissor_polygon := polygon_2d
	
	for polygon : Polygon2D in polygon2D_in_scene:
		if polygon == scissor_polygon:
			return
		# we offset them both to take into account the polygon position inside the parent
		var offset_scissors_poly : PackedVector2Array = PolygonCreator.rotate_polygon(scissor_polygon.polygon,self.rotation)
		offset_scissors_poly = Transform2D(0,scissor_polygon.global_position)*offset_scissors_poly
		var offset_poly := Transform2D(0,polygon.global_position)*polygon.polygon
		
		#here we are just checking if the scissors collider intersects with the any of the polygons in the scene
		var result : Array = Geometry2D.intersect_polygons(offset_poly, offset_scissors_poly)
		if result : #if there is any result then that means that there has been an intesection
			var clip_result := Geometry2D.clip_polygons(offset_poly,offset_scissors_poly)
			
			if clip_result.size() < 2:
				return
			
			# Create the broken polygon and delete the old one
			var new_poly := PolygonCreator.create_polygon(clip_result[0])
			new_poly.color = polygon.color
			get_tree().current_scene.add_child(new_poly)
			polygon.queue_free()
			
			#Create the other polygon as broken branch
			
			var new_branch := BROKEN_BRANCH.instantiate()
			new_branch.position = self.position
			new_branch.set_polygon(clip_result[1])
			new_branch.set_polygon_color(polygon.color)
			get_tree().current_scene.add_child(new_branch)

func _rotate_left(delta) -> void:
	self.rotation -= rotation_speed *delta

func _rotate_right(delta) -> void:
	self.rotation += rotation_speed *delta
