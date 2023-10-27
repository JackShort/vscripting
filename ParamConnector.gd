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

        if second_param.is_exec:
            if first_param.is_exec:
                Global.graph.graph_dict[first_param.parent_node_sig]["next"] = second_param.parent_node_sig
            else:
                if Global.graph.graph_dict[first_param.parent_node_sig].has("inputs_next"):
                    Global.graph.graph_dict[first_param.parent_node_sig]["inputs_next"][first_param.label.text] = second_param.parent_node_sig
                else:
                    Global.graph.graph_dict[first_param.parent_node_sig]["inputs_next"] = {
                        first_param.label.text: second_param.parent_node_sig
                    }
        else:
            if Global.graph.graph_dict[second_param.parent_node_sig].has("inputs"):
                Global.graph.graph_dict[second_param.parent_node_sig]["inputs"][second_param.label.text] = {
                    "node": first_param.parent_node_sig,
                    "param_name": first_param.label.text
                }
            else:
                Global.graph.graph_dict[second_param.parent_node_sig]["inputs"] = {
                    second_param.label.text: {
                        "node": first_param.parent_node_sig,
                        "param_name": first_param.label.text
                    }
                }
    else:
        first_param = param

func _process(_delta):
    if first_param and !is_instance_valid(first_param):
        queue_free()
        return
    
    if second_param and !is_instance_valid(second_param):
        first_param.line_segment = null
        queue_free()
        return

    if first_param:
        points[0] = param_button_center(first_param)
    
    if second_param:
        points[1] = param_button_center(second_param)
    else:
        points[1] = get_global_mouse_position()

func param_button_center(param: GraphNodeParameter):
    return param.parameter_button.global_position + param.parameter_button.size / 2
