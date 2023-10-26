extends VBoxContainer
class_name Debugger

var debug_panel = preload("res://Debug/DebugPanel.tscn")
var debug_value = preload("res://Debug/DebugValue.tscn")

var debug_map = Dictionary()

func create_debug_panel(title: String):
    var panel := debug_panel.instantiate()
    var panel_title: Label = panel.get_node("%Title")
    panel_title.text = title
    add_child(panel)

    debug_map[title] = { "node": panel, "data": Dictionary() }

func add_debug_value(title: String, key: String, value: String):
    var panel = debug_map[title]["node"]

    var key_node: Label = debug_value.instantiate()
    var value_node: Label = debug_value.instantiate()

    key_node.text = key
    value_node.text = value
    debug_map[title]["data"][key] = value_node

    var container = panel.get_node("Container")
    container.add_child(key_node)
    container.add_child(value_node)

func update_debug_value(title: String, key: String, value: String):
    debug_map[title]["data"][key].text = value
