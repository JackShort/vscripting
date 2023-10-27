extends GraphNodeData
class_name GraphSetNodeData

func exec(node_sig):
    var serialized_inputs = Global.graph.graph_dict[node_sig]["inputs"]
    var first_input_sig = serialized_inputs['value']['node']
    var first_input_name = serialized_inputs['value']['param_name']

    var first_input_val = get_graph_output_value(first_input_sig, first_input_name)

    var param: SolParameter = Global.vm_state["parameters"][parameter_name]
    param.value = first_input_val
