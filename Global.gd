extends Node

signal added_function
signal add_parameter_to_track(parameter_name: String)

@onready var graph_node_data_scene = preload("res://GraphNodeData.tscn")
@onready var graph_set_node_data_scene = preload("res://GraphSetNodeData.tscn")

enum SolType {
    sol_uint256,
    sol_bool,
    sol_mapping
}

var sol_types_to_string = {
    SolType.sol_uint256: "uint256",
    SolType.sol_bool: "bool",
    SolType.sol_mapping: "mapping",
}

var graph_node_list: GraphNodeList = null
var graph: Graph = null
var vm_state: Dictionary = {}

func add_node_to_graph(node: Node):
    graph.add_child(node)

func add_function_to_node_list(function_name: String):
    var graph_node_data = graph_node_data_scene.instantiate()
    graph_node_data.name = function_name
    graph_node_data.is_executable = false
    graph_node_list.add_child(graph_node_data)
    added_function.emit()

func add_parameter_to_node_list(parameter_name: String):
    var graph_node_data = graph_node_data_scene.instantiate()
    graph_node_data.name = "get_" + parameter_name
    graph_node_data.is_executable = false
    graph_node_data.can_execute = false
    graph_node_data.parameter_name = parameter_name
    graph_node_data.outputs.append("value")
    graph_node_list.add_child(graph_node_data)

    var set_graph_node_data: GraphSetNodeData  = graph_set_node_data_scene.instantiate()
    set_graph_node_data.name = "set_" + parameter_name
    set_graph_node_data.parameter_name = parameter_name
    set_graph_node_data.inputs.append("value")
    graph_node_list.add_child(set_graph_node_data)
