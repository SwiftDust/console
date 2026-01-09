extends TileMapLayer

#var moisture = FastNoiseLite.new()
#var temperature = FastNoiseLite.new()
#var altitude = FastNoiseLite.new()
#var width = 16
#var height = 16
#@onready var player: CharacterBody2D = $"../Player"
#
#
#func _ready() -> void:
	#moisture.seed = randi()
	#temperature.seed = randi()
	#altitude.seed = randi()
#
#func _process(delta: float) -> void:
	#generate_chunk(player.position)
	#
#func generate_chunk(position):
	#var tile_pos = local_to_map(position)
	#for x in range(width):
		#for y in range(height):
			#var moist = moisture.get_noise_2d(tile_pos.x + x, tile_pos.y + y)
			#var temp = temperature.get_noise_2d(tile_pos.x + x, tile_pos.y + y)
			#var alt = altitude.get_noise_2d(tile_pos.x + x, tile_pos.y + y)
			#set_cell(0, Vector2i(tile_pos.x + x, tile_pos.y + y), 2, Vector2i(9, 5))
