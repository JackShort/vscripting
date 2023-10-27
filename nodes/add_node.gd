extends GraphNodeData

func exec(node_sig):
    var serialized_inputs = Global.graph.graph_dict[node_sig]["inputs"]
    var first_input_sig = serialized_inputs['a']['node']
    var first_input_name = serialized_inputs['a']['param_name']
    var second_input_sig = serialized_inputs['b']['node']
    var second_input_name = serialized_inputs['b']['param_name']

    var first_input_val = get_graph_output_value(first_input_sig, first_input_name)
    var second_input_val = get_graph_output_value(second_input_sig, second_input_name)

    Global.graph.graph_dict[node_sig]['outputs'] = {
        'sum': int(first_input_val) + int(second_input_val)
    }

    print(int(first_input_val) + int(second_input_val))
