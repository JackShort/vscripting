extends GraphNodeData

func exec(node_sig):
    var input_arrays = get_graph_inputs(node_sig, ['conditional'])
    var first_input_sig = input_arrays[0][0]
    var first_input_name = input_arrays[1][0]

    var conditional_value = evaluate_input(first_input_sig, first_input_name)
    var true_next_sig = Global.graph.graph_dict[node_sig]["inputs_next"]["True"]
    var false_next_sig = Global.graph.graph_dict[node_sig]["inputs_next"]["False"]

    if conditional_value:
        if Global.graph.graph_dict[node_sig].has("next"):
            Global.graph.graph_dict[node_sig]["next"] = true_next_sig
        else:
            Global.graph.graph_dict[node_sig] = {
                "next": true_next_sig
            }
        return
    
    if Global.graph.graph_dict[node_sig].has("next"):
         Global.graph.graph_dict[node_sig]["next"] = false_next_sig
    else:
         Global.graph.graph_dict[node_sig] = {
            "next": false_next_sig
         }

func evaluate_input(first_input_sig, first_input_name):
    var first_input_val = get_graph_output_value(first_input_sig, first_input_name)

    if first_input_val is bool:
        first_input_val = "true" if first_input_val else "false"

    return first_input_val == "true"
