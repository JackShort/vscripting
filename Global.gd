extends Node

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