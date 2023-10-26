extends Node2D

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT:
            _add_node(get_global_mouse_position())

func _add_node(mouse_position: Vector2):
    print(mouse_position)
