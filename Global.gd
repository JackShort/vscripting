extends Node

@onready var graph_node_data_scene = preload("res://GraphNodeData.tscn")

enum SolType {
    sol_uint256,
    sol_bool
}

var sol_types_to_string = {
    SolType.sol_uint256: "uint256",
    SolType.sol_bool: "bool",
}

var graph_node_list: GraphNodeList = null
var graph: Graph = null
var vm_state: Dictionary = {}

func add_node_to_graph(node: Node):
    graph.add_child(node)

func add_function_to_node_list(function_name: String):
    var graph_node_data = graph_node_data_scene.instantiate()
    graph_node_data.name = function_name
    graph_node_list.add_child(graph_node_data)