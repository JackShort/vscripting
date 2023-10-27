extends GraphNodeData

func exec(node_sig):
    var serialized_inputs = Global.graph.graph_dict[node_sig]["inputs"]
    var first_input_sig = serialized_inputs['a']['node']
    var first_input_name = serialized_inputs['a']['param_name']
    var second_input_sig = serialized_inputs['b']['node']
    var second_input_name = serialized_inputs['b']['param_name']

    var first_input_val = Global.graph.graph_dict[first_input_sig]['outputs'][first_input_name]
    var second_input_val = Global.graph.graph_dict[second_input_sig]['outputs'][second_input_name]

    Global.graph.graph_dict[node_sig]['outputs'] = {
        'sum': int(first_input_val) + int(second_input_val)
    }
