extends VBoxContainer

@onready var param_display_scene = preload("res://FunctionDisplay.tscn")
@onready var add_function_button = %AddFunctionButton
@onready var function_input = %FunctionsInput
@onready var function_container = %FunctionsContainer

func _ready():
    add_function_button.button_down.connect(_on_add_param)

func _on_add_param():
    var function_name = function_input.text

    if function_name == "":
        return

    if not Global.vm_state.has("functions"):
        Global.vm_state["functions"] = {}

    var sol_function = SolFunction.new(function_name)
    Global.vm_state["functions"][function_name]  = sol_function
    var param_displayer = param_display_scene.instantiate()
    function_container.add_child(param_displayer)
    param_displayer.get_node("NameLabel").text = sol_function.name

    function_input.clear()
