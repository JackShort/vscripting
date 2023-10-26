extends Node

var graph_node_list: GraphNodeList = null
var graph: Graph = null

func add_node_to_graph(node: Node):
    graph.add_child(node)