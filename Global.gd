extends Node

enum SolTypes {
    sol_uint8,
    sol_uint256,
    sol_bool
}

var sol_types_to_string = {
    SolTypes.sol_uint8: "uint8",
    SolTypes.sol_uint256: "uint256",
    SolTypes.sol_bool: "bool",
}

var graph_node_list: GraphNodeList = null
var graph: Graph = null
var vm_state: Dictionary = {}

func add_node_to_graph(node: Node):
    graph.add_child(node)