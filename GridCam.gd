extends Camera2D

var deadzone = 0.01
var zoom_factor: float = 1.07
var max_zoom: Vector2 = Vector2(3, 3)
var min_zoom: Vector2 = Vector2(0.5, 0.5)
var pan_speed: float = 800.0

var wish_zoom_factor := 0.0
var wish_pan_direction := Vector2.ZERO

func _input(event):
    if event is InputEventMagnifyGesture:
        var zoom_strength = event.factor - 1.0
        if (abs(zoom_strength) < deadzone):
            return
        
        if (zoom_strength > 0):
            wish_zoom_factor = zoom_factor
        else:
            wish_zoom_factor = 1/zoom_factor
    elif event is InputEventPanGesture:
        wish_pan_direction = event.delta.normalized()

func _physics_process(delta):
    if wish_zoom_factor > 0:
        zoom_towards_cursor(wish_zoom_factor)
        wish_zoom_factor = 0.0

    if not wish_pan_direction.is_zero_approx():
        global_position += wish_pan_direction * pan_speed * delta * (1 / zoom.x)
        wish_pan_direction = Vector2.ZERO


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
