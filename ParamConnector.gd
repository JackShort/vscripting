extends Line2D
class_name ParamConnector

var initialized := false
var first_param: GraphNodeParameter = null
var second_param: GraphNodeParameter = null

func _ready():
    points = [0, 0]
    width = 1.5

func attach_param(param: GraphNodeParameter, second = false):
    if second:
        second_param = param
        initialized = true
    else:
        first_param = param

func _process(_delta):
    if first_param:
        points[0] = param_button_center(first_param)
    
    if second_param:
        points[1] = param_button_center(second_param)
    else:
        points[1] = get_global_mouse_position()

func param_button_center(param: GraphNodeParameter):
    return param.parameter_button.global_position + param.parameter_button.size / 2