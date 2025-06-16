import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Resizable Layout Example')),
        body: ResizableSplitView(
          leftChild: Container(
            color: Colors.orangeAccent,
            child: Center(child: Text('Left')),
          ),
          rightChild: Container(
            color: Colors.purpleAccent,
            child: Center(child: Text('Right')),
          ),
        ),
      ),
    );
  }
}

class ResizableSplitView extends StatefulWidget {
  final Widget leftChild;
  final Widget rightChild;

  ResizableSplitView({Key? key, required this.leftChild, required this.rightChild}) : super(key: key);
  @override
  _ResizableSplitViewState createState() => _ResizableSplitViewState();

}

class _ResizableSplitViewState extends State<ResizableSplitView> {
  double _dividerPosition = 0.5; // Divider position as a fraction of total width.

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double totalWidth = constraints.maxWidth;
        double leftWidth = totalWidth * _dividerPosition;
        double rightWidth = totalWidth * (1 - _dividerPosition);

        return Stack(
          children: [
            CustomMultiChildLayout(
              delegate: _ResizableLayoutDelegate(leftWidth, rightWidth),
              children: [
                LayoutId(
                  id: 'left',
                  child: widget.leftChild,
                ),
                LayoutId(
                  id: 'right',
                  child: widget.rightChild,
                ),
              ],
            ),
            Positioned(
              left: leftWidth - 10,
              top: 0,
              bottom: 0,
              child: GestureDetector(

                onHorizontalDragUpdate: (details) {
                  setState(() {

                    _dividerPosition += details.primaryDelta! / totalWidth;
                    _dividerPosition = _dividerPosition.clamp(0.1, 0.9); // Keep within bounds.
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeLeftRight,
                  child: Container(

                    width: 20,
                    color: Colors.grey.withOpacity(0.1),
                    child: Center(
                      child: Container(
                        height: double.infinity,
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ResizableLayoutDelegate extends MultiChildLayoutDelegate {
  final double leftWidth;
  final double rightWidth;

  _ResizableLayoutDelegate(this.leftWidth, this.rightWidth);

  @override
  void performLayout(Size size) {
    if (hasChild('left')) {
      layoutChild('left', BoxConstraints.tight(Size(leftWidth, size.height)));
      positionChild('left', Offset(0, 0));
    }

    if (hasChild('right')) {
      layoutChild('right', BoxConstraints.tight(Size(rightWidth, size.height)));
      positionChild('right', Offset(leftWidth, 0));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) {
    return true;
  }
}
