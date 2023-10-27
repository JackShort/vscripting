extends GraphNodeData

func exec(node_sig):
    var input_arrays = get_graph_inputs(node_sig, ['address', 'id'])
    var first_input_sig = input_arrays[0][0]
    var first_input_name = input_arrays[1][0]
    var second_input_sig = input_arrays[0][1]
    var second_input_name = input_arrays[1][1]

    var first_input_val = get_graph_output_value(first_input_sig, first_input_name)
    var second_input_val = get_graph_output_value(second_input_sig, second_input_name)

    if not Global.vm_state.has("parameters"):
        Global.vm_state["parameters"] = {}
    
    if not Global.vm_state["parameters"].has("_owners"):
        Global.vm_state["parameters"]["_owners"] = SolParameter.new("_owners", Global.SolType.sol_mapping)

    if not Global.vm_state["parameters"].has("_balances"):
        Global.vm_state["parameters"]["_balances"] = SolParameter.new("_balances", Global.SolType.sol_mapping)

    Global.vm_state["parameters"]["_owners"].value[second_input_val] = first_input_val

    if Global.vm_state["parameters"]["_balances"].value.has(first_input_val):
        Global.vm_state["parameters"]["_balances"].value[first_input_val] += 1
    else:
        Global.vm_state["parameters"]["_balances"].value[first_input_val] = 1
    
    Global.add_parameter_to_track.emit("_owners")
    Global.add_parameter_to_track.emit("_balances")
