import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ClockView extends StatefulWidget {
  @override
  _ClockViewState createState() => _ClockViewState();
}

class _ClockViewState extends State<ClockView> {
  Timer timer;
  @override
  // ignore: must_call_super
  void initState() {
    this.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
  }
  @override
  void dispose() {
    this.timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width*0.65,
      height: Get.width*0.65,
      child: Transform.rotate(
        angle: -pi / 2,
        child:  CustomPaint(
          painter: ClockPainter(),
        ),
      ),
    );
  }
}
// class ClockView extends GetView<ClockController> {
//
// }

class ClockPainter extends CustomPainter{
  var dateTime = DateTime.now();

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var center = Offset(centerX, centerY);
    var radius = min(centerX, centerY)-15;

    var fillBrush = Paint()
      ..color = Color(0xFF444974);
    var outlineBrush = Paint()
      ..color = Color(0xFFEAECFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    var centerFillBrush = Paint()
      ..color = Color(0xFFEAECFF);
    var secHanBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.lightBlue, Colors.blue])
    .createShader(Rect.fromCircle(center: center, radius: radius))
    ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
    ..strokeWidth = 2;
    var miuHanBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.blueGrey, Colors.grey])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    var hourHanBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.blueGrey, Colors.grey])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;
    var dashBrush = Paint()
      ..shader = RadialGradient(colors: [Colors.white70, Colors.blue])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.5;
    var dashBrushMain = Paint()
      ..shader = RadialGradient(colors: [Colors.white70, Colors.white])
          .createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, fillBrush);
    canvas.drawCircle(center, radius, outlineBrush);

    var secHandX = centerX + 85 * cos(dateTime.second * 6 * pi/180);
    var secHandY = centerY + 85 * sin(dateTime.second * 6 * pi/180);
    canvas.drawLine(center, Offset(secHandX, secHandY), secHanBrush);
    var miuHandX = centerX + 70 * cos(dateTime.minute * 6 * pi/180);
    var miuHandY = centerY + 70 * sin(dateTime.minute * 6 * pi/180);
    canvas.drawLine(center, Offset(miuHandX, miuHandY), miuHanBrush);
    var hourHandX = centerX + 50 * cos((dateTime.hour * 30 + dateTime.hour * 0.5) * pi/180);
    var hourHandY = centerY + 50 * sin((dateTime.hour * 30 + dateTime.hour * 0.5) * pi/180);
    canvas.drawLine(center, Offset(hourHandX, hourHandY), hourHanBrush);

    var outerCircleRadius = radius;
    var innterCircleRadius = radius - 14;
    canvas.drawCircle(center, 5, centerFillBrush);
    for(int i = 0 ; i<360; i+=5){
      var x1 = centerX + outerCircleRadius * cos(  i * pi / 180);
      var y1 = centerX + outerCircleRadius * sin(  i * pi / 180);

      var x2 = centerX + innterCircleRadius * cos(  i * pi / 180);
      var y2 = centerX + innterCircleRadius * sin(  i * pi / 180);
      if(i == 0 || i == 90 || i == 180 || i==270 || i== 360){
        canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrushMain);
      }else{
        if(i % 10 == 0){
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), dashBrush);
        }
      }

    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}