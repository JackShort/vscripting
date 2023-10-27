extends GraphNodeData

func exec(node_sig):
    var input_arrays = get_graph_inputs(node_sig, ['target'])
    var first_input_sig = input_arrays[0][0]
    var first_input_name = input_arrays[1][0]

    var input = Global.graph.graph_dict[first_input_sig]['outputs'][first_input_name]
    input.value += 1
