extends VBoxContainer

@onready var type_option_button = %ParamTypeDropdown
@onready var add_param_button = %AddParamButton
@onready var param_input = %ParamInput

func _ready():
    add_param_button.button_down.connect(_on_add_param)

    for key in Global.sol_types_to_string:
        type_option_button.add_item(Global.sol_types_to_string[key], key)

func _on_add_param():
    print(param_input.text)
    param_input.clear()
    print(type_option_button.get_item_id(type_option_button.selected))