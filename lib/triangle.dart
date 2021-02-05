import 'package:flutter/material.dart';

class SpecialChatBubbleOne extends CustomPainter {
  final Alignment alignment;
  final bool tail;

  SpecialChatBubbleOne({
    this.alignment,
    this.tail,
  });

  double _radius = 10.0;
  double _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (alignment == Alignment.topRight) {
      if (tail) {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width - _x,
              size.height,
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill);
        var path = new Path();
        path.moveTo(size.width - _x, 0);
        path.lineTo(size.width - _x, 10);
        path.lineTo(size.width, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              size.width - _x,
              0.0,
              size.width,
              size.height,
              topRight: Radius.circular(3),
            ),
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0,
              size.width - _x,
              size.height,
              bottomLeft: Radius.circular(_radius),
              bottomRight: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
            ),
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill);
      }
    } else {
      if (tail) {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              _x,
              0,
              size.width,
              size.height,
              bottomRight: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill);
        var path = new Path();
        path.moveTo(_x, 0);
        path.lineTo(_x, 10);
        path.lineTo(0, 0);
        canvas.clipPath(path);
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              0,
              0.0,
              _x,
              size.height,
              topLeft: Radius.circular(3),
            ),
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill);
      } else {
        canvas.drawRRect(
            RRect.fromLTRBAndCorners(
              _x,
              0,
              size.width,
              size.height,
              bottomRight: Radius.circular(_radius),
              topRight: Radius.circular(_radius),
              bottomLeft: Radius.circular(_radius),
              topLeft: Radius.circular(_radius),
            ),
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.fill);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class BubbleSpecialOne extends StatelessWidget {
  final bool isSender;
  final String text;

  const BubbleSpecialOne({
    Key key,
    this.isSender = true,
    @required this.text,
  });

  ///chat bubble builder method
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 20,
            ),
          ],
        ),
        child: CustomPaint(
          painter: SpecialChatBubbleOne(
              alignment: isSender ? Alignment.topRight : Alignment.topLeft,
              tail: true),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * .7,
            ),
            margin: EdgeInsets.fromLTRB(7, 7, 17, 7),
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  child: Container(
                    width: 180,
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
