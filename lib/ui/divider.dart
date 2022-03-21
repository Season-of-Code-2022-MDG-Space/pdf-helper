import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class StatefulDragArea extends StatefulWidget {
  final Widget child;

  const StatefulDragArea({Key? key, required this.child}) : super(key: key);

  @override
  _DragAreaStateStateful createState() => _DragAreaStateStateful();
}

class _DragAreaStateStateful extends State<StatefulDragArea> {
  double? _x = 100;
  double? _y = 100;
  updatePosition(x, y) {
    setState(() {
      _x = x;
      _y = y;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: _x,
        top: _y,
        child: Draggable(
          child: Image.asset('divider.png'),
          childWhenDragging: Image.asset('divider.png'),
          feedback: Image.asset('divider.png'),
          onDragEnd: (dragDetails) {
            setState(() {
              _x = dragDetails.offset.dx;
              _y = dragDetails.offset.dy;
            });
          },
        ));
  }
}
