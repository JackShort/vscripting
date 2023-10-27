extends Node
class_name GraphNodeData

@export var is_executable := true
@export var can_execute := true
@export var inputs: Array[String] = []
@export var outputs: Array[String] = []

var parameter_name := ''

func exec(_node_sig):
    pass

func get_graph_output_value(node_sig, input_name):
    var input = Global.graph.graph_dict[node_sig]['outputs'][input_name]

    if input is SolParameter:
        return input.value

    return input

func set_graph_outputs(node_sig: String, args: Array[String], values: Array):
    for i in args.size():
        Global.graph.graph_dict[node_sig]["outputs"][args[i]] = values[i]

func get_graph_inputs(node_sig: String, inputs: Array[String]):
    var serialized_inputs = Global.graph.graph_dict[node_sig]["inputs"]
    var node_sigs = []
    var param_names = []

    for input in inputs:
        node_sigs.append(serialized_inputs[input]['node'])
        param_names.append(serialized_inputs[input]['param_name'])
    
    return [node_sigs, param_names]
