extends Node2D

@onready var camera_2d: Camera2D = $Player/Camera2D
#@onready var player_collision_shape_node: CollisionShape2D = $Player/CollisionShape2D
@onready var player: CharacterBody2D = $Player

@onready var player_collision_shape_node = player.get_node("CollisionShape2D")
@onready var player_collision_shape = player_collision_shape_node.shape
@onready var ground: TileMapLayer = $Ground

var platforms := []
var height_addition: float = 5.0
var screen_size: Vector2 = DisplayServer.screen_get_size()
var screen_x: float = screen_size.x
var screen_y: float = screen_size.y

var camera_size: Vector2 = Vector2()
var camera_rect: Rect2 = Rect2()


func _ready() -> void:
	randomize()
	spawn_tilemap(5)
	
func spawn_tilemap(amount: int) -> void:
	var platform_position = {"x": 0, "y": 0} # sets initial platform position
	if is_instance_valid(camera_2d):
		camera_size = get_viewport_rect().size * camera_2d.zoom
		camera_rect = Rect2(camera_2d.get_screen_center_position() - camera_size / 2, camera_size)
		print(camera_size)
		print(camera_rect)
	else:
		print(camera_2d)
	for i in range(amount):
		
		var highest_y = camera_rect.end.y
		if is_instance_valid(player_collision_shape) and is_instance_valid(player_collision_shape_node):
			var height_increment = player_collision_shape.size.y * player_collision_shape_node.global_scale.y * 3.5
			var margin := 64
			platform_position = {
				#"x": randf_range(0, camera_rect.end.x - margin),
				#"y": randf_range(0, camera_rect.end.y - margin)
				"x": randi_range(0, camera_rect.end.x),
				"y": randi_range(0, camera_rect.end.y)
			}
			
			print(platform_position)
			print(platform_position["x"])
			
	
		# idk why this took me so long
		var tile_position: Vector2 = Vector2(platform_position["x"], platform_position["y"])
		var cell_coords: Vector2i = ground.local_to_map(tile_position)
		ground.set_cell(cell_coords, 2, Vector2i(9, 5))
		
