extends PanelContainer
class_name SearchBar

signal node_added

@onready var graph_node_scene = preload("res://GraphNode.tscn")
@onready var search_input: LineEdit = %SearchInput 
@onready var search_result1: Label = %Result1
@onready var search_result2: Label = %Result2
@onready var search_result3: Label = %Result3

var _top_graph_node: GraphNodeData = null

func _input(_event):
    if Input.is_action_pressed("ui_accept") and _top_graph_node:
        _add_graph_node()
        queue_free()

func _ready():
    search_input.grab_focus()
    search_input.text_changed.connect(_search)


func _levenshtein_distance(str1:String, str2:String)->int:
        str1 = str1.to_lower()
        str2 = str2.to_lower()
        var m:int = len(str1)
        var n:int = len(str2)
        var d: Array = []
        for i in range(1, m+1):
            d.append([i])
        d.insert(0, range(0, n+1))
        for j in range(1, n+1):
            for i in range(1, m+1):
                var substitution_cost: int
                if str1[i-1] == str2[j-1]:
                    substitution_cost = 0
                else:
                    substitution_cost = 1
                d[i].insert(j, min(min(
                    d[i-1][j]+1,
                    d[i][j-1]+1),
                    d[i-1][j-1]+substitution_cost))
        return d[-1][-1]

func _search(text: String):
    if text == "":
        search_result1.visible = false
        search_result2.visible = false
        search_result3.visible = false
        return

    var graph_nodes = Global.graph_node_list.get_children() as Array[GraphNodeData]
    var order := []

    for i in graph_nodes.size():
        var dist := _levenshtein_distance(text, graph_nodes[i].name)
        order.append([dist, i])

    order.sort_custom(func(a, b): return a[0] < b[0])
    order = order.slice(0, 5)
    _top_graph_node = graph_nodes[order[0][1]]

    search_result1.text = graph_nodes[order[0][1]].name
    search_result2.text = graph_nodes[order[1][1]].name
    search_result3.text = graph_nodes[order[2][1]].name

    search_result1.visible = true
    search_result2.visible = true
    search_result3.visible = true

func _add_graph_node():
    var graph_node = graph_node_scene.instantiate()
    get_parent().add_child(graph_node)
    graph_node.global_position = global_position
    graph_node.select_node()

    var node_sig = _top_graph_node.name + str(Global.graph.added_nodes)
    var exec = _top_graph_node.exec
    Global.graph.added_nodes += 1

    if Global.vm_state.has("functions") and _top_graph_node.name in Global.vm_state["functions"].keys():
        node_sig = _top_graph_node.name
        exec = func(_node_sig): print("RUNNING")

    Global.graph.graph_dict[node_sig] = {
        "name": _top_graph_node.name,
        "exec": exec,
        "inputs": {},
        "outputs": {},
    }
    graph_node.init(_top_graph_node, node_sig)
    node_added.emit()
