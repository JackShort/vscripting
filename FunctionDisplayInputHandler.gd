extends VBoxContainer

@onready var param_display_scene = preload("res://ParameterDisplay.tscn")

@onready var input_type_option_button = %InputParamTypeDropdown
@onready var input_add_param_button = %AddInputParamButton
@onready var input_param_input = %InputParamInput
@onready var input_parameter_container = %InputParameterContainer

@onready var output_type_option_button = %OutputParamTypeDropdown
@onready var output_add_param_button = %AddOutputParamButton
@onready var output_param_input = %OutputParamInput
@onready var output_parameter_container = %OutputParameterContainer

func _ready():
    input_add_param_button.button_down.connect(_on_add_param.bind(false))
    output_add_param_button.button_down.connect(_on_add_param.bind(true))

    for key in Global.sol_types_to_string:
        input_type_option_button.add_item(Global.sol_types_to_string[key], key)
        output_type_option_button.add_item(Global.sol_types_to_string[key], key)

func _on_add_param(output: bool):
    var param_input = input_param_input if !output else output_param_input
    var type_option_button = input_type_option_button if !output else output_type_option_button
    var parameter_container = input_parameter_container if !output else output_parameter_container

    var param_name = param_input.text
    var param_type = type_option_button.get_item_id(type_option_button.selected)

    if param_name == "":
        return

    var key = "input" if !output else "output"
    if not Global.vm_state["functions"].has(key):
        Global.vm_state["functions"][key] = {}

    var sol_param = SolParameter.new(param_name, param_type)
    Global.vm_state["functions"][key][param_name]  = sol_param
    var param_displayer = param_display_scene.instantiate()
    parameter_container.add_child(param_displayer)
    param_displayer.get_node("NameLabel").text = sol_param.name
    param_displayer.get_node("TypeLabel").text = Global.sol_types_to_string[sol_param.type]
    param_displayer.get_node("Value").text = str(sol_param.value)

    print(Global.vm_state)

    param_input.clear()
