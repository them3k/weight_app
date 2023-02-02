import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // start path
    path.lineTo(0, 50);

    // P1
    var firstStart = Offset(size.width * 0.2, 20);

    // P2
    var firstEnd = Offset(size.width * 0.5, 20);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    //P3
    var secondStart = Offset(size.width * 0.8, 25);
    //P4
    var secondEnd = Offset(size.width, 60);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}