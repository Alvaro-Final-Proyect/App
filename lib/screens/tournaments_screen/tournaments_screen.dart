import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';

class TournamentsPage extends StatelessWidget {
  TournamentsPage({Key? key}) : super(key: key);

  final graph = Graph()..isTree = true;
  final builder = BuchheimWalkerConfiguration();
  final nodes = <Map<String, dynamic>>[
      {'id': 1, 'label': 'circle'},
      {'id': 2, 'label': 'ellipse'},
      {'id': 3, 'label': 'square'}
  ];

  final edges = <Map<String, int>>[
      {'from': 1, 'to': 3},
      {'from': 1, 'to': 2},
  ];

  void init() {
    for (var element in edges) {
      var fromNodeId = element['from'];
      var toNodeId = element['to'];
      graph.addEdge(Node.Id(fromNodeId), Node.Id(toNodeId));
    }

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_RIGHT_LEFT);
  }

  @override
  Widget build(BuildContext context) {
    init();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tournaments'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: InteractiveViewer(
              constrained: false,
              child: GraphView(
                graph: graph,
                algorithm: BuchheimWalkerAlgorithm(
                    builder, TreeEdgeRenderer(builder)),
                paint: Paint()
                  ..color = Colors.green
                  ..strokeWidth = 1
                  ..style = PaintingStyle.stroke,
                builder: (Node node) {
                  // I can decide what widget should be shown here based on the id
                  var nodeId = node.key?.value as int;
                  var currentNode = nodes.firstWhere((element) => nodeId == element['id'] as int);
                  return MatchItem(currentNode: currentNode);
                },
              )
            )
          ),
        ],
      ),
    );
  }
}

class MatchItem extends StatelessWidget {
  const MatchItem({
    Key? key,
    required this.currentNode,
  }) : super(key: key);

  final Map<String, dynamic> currentNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      padding: const EdgeInsets.all(20),
      child: Text(currentNode['label'] as String),
    );
  }
}
