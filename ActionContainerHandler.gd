extends PanelContainer

@onready var runner_dropdown = %RunnerDropdown
@onready var runnner_button = %RunnerButton

func _ready():
    runnner_button.button_down.connect(_on_button_down)
    Global.added_function.connect(refresh_runner)

func _on_button_down():
    print("should run")

func refresh_runner():
    runner_dropdown.clear()

    for key in Global.vm_state["functions"]:
        runner_dropdown.add_item(key)
