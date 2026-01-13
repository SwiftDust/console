class_name PlatformSpawner extends Node2D


@onready var camera_2d: Camera2D = $"../Player/Camera2D"
#@onready var player_collision_shape_node: CollisionShape2D = $Player/CollisionShape2D
@onready var player: CharacterBody2D = $"../Player"

@onready var player_collision_shape_node = player.get_node("CollisionShape2D")
@onready var player_collision_shape = player_collision_shape_node.shape
@onready var ground: TileMapLayer = $"../Ground"

var platform_rows: Array[int] = []
var PLATFORM_WIDTH := 3
var height_addition: float = 5.0
var screen_size: Vector2 = DisplayServer.screen_get_size()
var screen_x: float = screen_size.x
var screen_y: float = screen_size.y

var camera_size: Vector2 = Vector2()
var camera_rect: Rect2 = Rect2()


func _ready() -> void:
	randomize()
	spawn_tilemap(100)
	
func spawn_tilemap(amount: int) -> void:
	var platform_position = {"x": 0, "y": 0} # sets initial platform position
	
	if is_instance_valid(camera_2d):
		camera_size = get_viewport_rect().size * camera_2d.zoom
		camera_rect = Rect2(camera_2d.get_screen_center_position() - camera_size / 2, camera_size)
	else:
		print(camera_2d)
	
	var highest_y = camera_rect.end.y

	
	for i in range(amount):
		if is_instance_valid(player_collision_shape) and is_instance_valid(player_collision_shape_node):
			var height_increment = player_collision_shape.size.y * player_collision_shape_node.global_scale.y * 3.5
			var margin := 64
			platform_position = {
				"x": randf_range(0, camera_rect.end.x - margin),
				"y": highest_y - height_increment
			}
			
		var tile_left =  Vector2i(7, 4)
		var tile_middle = Vector2i(7, 5)
		var tile_right = Vector2i(7, 6)
		var tiles = [tile_left, tile_middle, tile_right]

		var tile_position: Vector2 = Vector2(platform_position.x, platform_position.y)
		
		var left_cell_coords: Vector2i = ground.local_to_map(tile_position) + Vector2i(-1, 0)
		var middle_cell_coords: Vector2i = ground.local_to_map(tile_position)
		var right_cell_coords: Vector2i = ground.local_to_map(tile_position) + Vector2i(1, 0)
		
		for tile in tiles:
			match tile:
				tile_left:
					ground.set_cell(left_cell_coords, 2, tile, 3)
				tile_middle:
					ground.set_cell(middle_cell_coords, 2, tile, 2)
				tile_right:
					ground.set_cell(right_cell_coords, 2, tile, 2)

		highest_y = platform_position.y

# DISCLAIMER: THIS CODE DOESN'T WORK AT ALL!!
#func cleanup_and_respawn() -> void:
	#if not is_instance_valid(camera_2d): return
#
	#camera_size = get_viewport_rect().size * camera_2d.zoom
	#camera_rect = Rect2(
		#camera_2d.get_screen_center_position() - camera_size / 2,
		#camera_size
	#)
#
	#var bottom_cell_y := ground.to_local(
		#Vector2(0, camera_rect.end.y)
	#)
#
	##var bottom_cell_y := ground.local_to_map(camera_bottom_local).y
#
	#var removed := 0
#
	#for y in platform_rows.duplicate():
		#if y > bottom_cell_y:
			#remove_platform_row(y)
			#platform_rows.erase(y)
			#removed += 1
#
	#if removed > 0:
		#spawn_tilemap(removed)
		#
#func remove_platform_row(y: int) -> void:
	#for x_offset in [-1, 0, 1]:
		#var cell := Vector2i(0, y) + Vector2i(x_offset, 0)
		#ground.erase_cell(cell)
#
#func _process(_delta: float) -> void:
	#cleanup_and_respawn()
