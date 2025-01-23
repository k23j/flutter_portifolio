import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_portifolio/project_01_board/board_square.dart';
import 'package:flutter_portifolio/utils/pair.dart';
import 'package:flutter_portifolio/utils/vector_2d.dart';

class Board extends StatefulWidget {
  const Board({super.key});

  @override
  State<Board> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  final int boardSize = 9;
  late final int itemCount;
  late final Map<Vector2d, GlobalKey<BoardSquareState>> squareStateMap;
  late final List<Widget> squareWidgetList;
  final Duration propagationInterval = Duration(milliseconds: 100);

  void propagate(Vector2d id, int layer) async {
    //If its first play and propagate
    if (layer == 0) {
      print("Propragate from $id");
      playGrowAnim(id);
    } else {
      List<Vector2d> layerVectorList = getListOfNeighoursAtLayer(id, layer);
      if (layerVectorList.isEmpty) return;

      for (var id in layerVectorList) {
        playGrowAnim(id);
      }
    }
    await Future.delayed(propagationInterval);
    propagate(id, layer + 1);
  }

  List<Vector2d> getListOfNeighoursAtLayer(Vector2d root, int layer) {
    Vector2d topLeft = Vector2d(root.x - layer, root.y - layer);
    Vector2d topRight = Vector2d(root.x + layer, root.y - layer);
    Vector2d bottomRight = Vector2d(root.x + layer, root.y + layer);
    Vector2d bottomLeft = Vector2d(root.x - layer, root.y + layer);

    //From topLeft to topRight
    List<Vector2d> unverifiedList = [];

    Vector2d currentVector = topLeft;

    //Map Direction, Target
    Queue<Pair<Vector2d, Vector2d>> directionList =
        Queue<Pair<Vector2d, Vector2d>>.from([
      Pair(Vector2d.right(), topRight),
      Pair(Vector2d.down(), bottomRight),
      Pair(Vector2d.left(), bottomLeft),
      Pair(Vector2d.up(), topLeft),
    ]);

    // Vector2d tempVector;
    while (directionList.isNotEmpty) {
      Pair<Vector2d, Vector2d> targetPair = directionList.removeFirst();

      currentVector += targetPair.first;

      while (currentVector != targetPair.second) {
        unverifiedList.add(currentVector);
        currentVector += targetPair.first;
      }

      unverifiedList.add(currentVector);
    }

    return unverifiedList
        .where((element) => squareStateMap.containsKey(element))
        .toList();
  }

  void playGrowAnim(Vector2d id) {
    var key = squareStateMap[id];
    if (key != null && key.currentState != null && key.currentState!.mounted) {
      key.currentState!.playGrowAnim();
    }
  }

  @override
  void initState() {
    itemCount = boardSize * boardSize;
    initSquareMap();
    super.initState();
  }

  void initSquareMap() {
    List<Vector2d> vecList =
        List<Vector2d>.generate(itemCount, (index) => indexToVector2d(index));

    squareStateMap = {
      for (var vec in vecList)
        vec: GlobalKey<BoardSquareState>(debugLabel: "Square[$vec]")
    };

    squareWidgetList = vecList
        .map((vec) => BoardSquare(
              vec,
              onClick: (id) => propagate(id, 0),
              key: squareStateMap[vec],
            ))
        .toList();

    //DEBUG
    print(squareStateMap);
    print(squareWidgetList);
  }

  Vector2d indexToVector2d(int id) {
    return Vector2d(id % boardSize, (id / boardSize).floor());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 400,
        height: 400,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: boardSize,
              childAspectRatio: 1.0,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2),
          physics: NeverScrollableScrollPhysics(),
          itemCount: itemCount,
          itemBuilder: (context, index) => squareWidgetList[index],
        ),
      ),
    );
  }
}
