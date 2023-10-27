extends PanelContainer

@onready var runner_dropdown = %RunnerDropdown
@onready var runnner_button = %RunnerButton

func _ready():
    runnner_button.button_down.connect(_on_button_down)
    Global.added_function.connect(refresh_runner)

func _on_button_down():
    var sig = runner_dropdown.get_item_text((runner_dropdown.selected))
    while Global.graph.graph_dict.has(sig) and Global.graph.graph_dict[sig].has("exec"):
        Global.graph.graph_dict[sig]["exec"].call(sig)

        if Global.graph.graph_dict[sig].has("next"):
            sig = Global.graph.graph_dict[sig]["next"]
        else:
            break

func refresh_runner():
    runner_dropdown.clear()

    for key in Global.vm_state["functions"]:
        runner_dropdown.add_item(key)
