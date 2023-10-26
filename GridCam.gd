extends Camera2D

var deadzone = 0.01
var zoom_factor: float = 1.01
var max_zoom: Vector2 = Vector2(2, 2)
var min_zoom: Vector2 = Vector2(0.5, 0.5)

func _input(event):
    if event is InputEventMagnifyGesture:
        var zoom_strength = event.factor - 1.0
        if (abs(zoom_strength) < deadzone):
            return
        
        if (zoom_strength > 0):
            zoom_towards_cursor(zoom_factor)
        else:
            zoom_towards_cursor(1/zoom_factor)
    elif event is InputEventPanGesture:
        print(event.as_text())



func zoom_towards_cursor(zoom_delta):
    var target_zoom = zoom * zoom_delta

    target_zoom.x = clamp(target_zoom.x, min_zoom.x, max_zoom.x)
    target_zoom.y = clamp(target_zoom.y, min_zoom.y, max_zoom.y)
    
    var viewport_mouse_position = get_viewport().get_mouse_position()
    var relative_mouse_pos = viewport_mouse_position / get_viewport_rect().size
    var camera_size = get_viewport_rect().size * (1.0 / target_zoom.x)
    var relative_global_pos = global_position + relative_mouse_pos * camera_size
    global_position += get_global_mouse_position() - relative_global_pos

    zoom = target_zoom
