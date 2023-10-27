extends VBoxContainer

@onready var param_display_scene = preload("res://ParameterDisplay.tscn")
@onready var type_option_button = %ParamTypeDropdown
@onready var add_param_button = %AddParamButton
@onready var param_input = %ParamInput
@onready var parameter_container = %ParameterContainer

func _ready():
    add_param_button.button_down.connect(_on_add_param)

    for key in Global.sol_types_to_string:
        type_option_button.add_item(Global.sol_types_to_string[key], key)

func _on_add_param():
    var param_name = param_input.text
    var param_type = type_option_button.get_item_id(type_option_button.selected)

    if param_name == "":
        return

    if not Global.vm_state.has("parameters"):
        Global.vm_state["parameters"] = {}

    var sol_param = SolParameter.new(param_name, param_type)
    Global.vm_state["parameters"][param_name]  = sol_param
    var param_displayer = param_display_scene.instantiate()
    parameter_container.add_child(param_displayer)
    param_displayer.get_node("NameLabel").text = sol_param.name
    param_displayer.get_node("TypeLabel").text = Global.sol_types_to_string[sol_param.type]
    param_displayer.get_node("Value").text = str(sol_param.value)

    Global.add_parameter_to_node_list(param_name)
    param_input.clear()

func _process(_delta):
    for child in parameter_container.get_children():
        child.get_node("Value").text = str(Global.vm_state["parameters"][child.get_node("NameLabel").text].value)
