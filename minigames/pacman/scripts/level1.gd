extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	print(get_cell_size())
	pass

func calculate_tilemap_size():
    # Get list of all positions where there is a tile
    var used_cells = self.get_used_cells()
    # If there are none, return null result
    if used_cells.size() == 0:
        return {x=0, y=0, width=0, height=0}

    # Take first cell as reference
    var min_x = used_cells[0].x
    var min_y = used_cells[0].y
    var max_x = min_x
    var max_y = min_y

    # Find bounds
    for i in range(1, used_cells.size()):

        var pos = used_cells[i]

        if pos.x < min_x:
            min_x = pos.x
        elif pos.x > max_x:
            max_x = pos.x

        if pos.y < min_y:
            min_y = pos.y
        elif pos.y > max_y:
            max_y = pos.y

    # Return resulting bounds
    return {
        x = min_x,
        y = min_y,
        width = max_x - min_x + 1,
        height = max_y - min_y + 1,
		cell_size = self.get_cell_size()
    }
