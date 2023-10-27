extends GraphNodeData

func exec(node_sig):
    var input_arrays = get_graph_inputs(node_sig, ['a', 'b'])
    var first_input_sig = input_arrays[0][0]
    var first_input_name = input_arrays[1][0]
    var second_input_sig = input_arrays[0][1]
    var second_input_name = input_arrays[1][1]

    var first_input_val = get_graph_output_value(first_input_sig, first_input_name)
    var second_input_val = get_graph_output_value(second_input_sig, second_input_name)

    var sum = int(first_input_val) + int(second_input_val)
    set_graph_outputs(node_sig, ['sum'], [sum])

    print(int(first_input_val) + int(second_input_val))
