extends ColorRect

@export var grid_step := 40
@export var grid_color := Color(0.5, 0.5, 0.5, 0.5)

func _draw_vertical_line(x_offset: int):
    draw_line(Vector2(x_offset, 0), Vector2(x_offset, size.y), grid_color)

func _draw_horizontal_line(y_offset: int):
    draw_line(Vector2(0, y_offset), Vector2(size.x, y_offset), grid_color)

func _draw():
    for i in int(size.x):
        if i % grid_step == 0:
            _draw_vertical_line(i)
    for i in int(size.y):
        if i % grid_step == 0:
            _draw_horizontal_line(i)
