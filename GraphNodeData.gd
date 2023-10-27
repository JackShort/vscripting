extends Node
class_name GraphNodeData

@export var is_executable := true
@export var can_execute := true
@export var inputs: Array[String] = []
@export var outputs: Array[String] = []

func exec(node_sig):
    var serialized_inputs = Global.graph.graph_dict[node_sig]["inputs"]
    var first_input_sig = serialized_inputs['a']['node']
    var first_input_name = serialized_inputs['a']['param_name']
    var second_input_sig = serialized_inputs['b']['node']
    var second_input_name = serialized_inputs['b']['param_name']
    var first_input_val = Global.graph.graph_dict[first_input_sig]['outputs'][first_input_name]
    var second_input_val = Global.graph.graph_dict[second_input_sig]['outputs'][second_input_name]

    print(int(first_input_val) + int(second_input_val))
