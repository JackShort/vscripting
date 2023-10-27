extends GraphNodeData

func exec(node_sig):
    var input_arrays = get_graph_inputs(node_sig, ['a', 'b'])
    var first_input_sig = input_arrays[0][0]
    var first_input_name = input_arrays[1][0]
    var second_input_sig = input_arrays[0][1]
    var second_input_name = input_arrays[1][1]

    var first_input_val = get_graph_output_value(first_input_sig, first_input_name)
    var second_input_val = get_graph_output_value(second_input_sig, second_input_name)

    var conditional_value = int(first_input_val) > int(second_input_val)
    var true_next_sig = Global.graph.graph_dict[node_sig]["inputs_next"]["True"]
    var false_next_sig = Global.graph.graph_dict[node_sig]["inputs_next"]["False"]

    if conditional_value:
        Global.graph.graph_dict[node_sig]["next"] = true_next_sig
        return
    
    if Global.graph.graph_dict[node_sig].has("next"):
         Global.graph.graph_dict[node_sig]["next"] = false_next_sig
    
