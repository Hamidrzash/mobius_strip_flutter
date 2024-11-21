import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MobiusStripPage(),
    );
  }
}

class MobiusStripPage extends StatefulWidget {
  const MobiusStripPage({super.key});

  @override
  State<MobiusStripPage> createState() => _MobiusStripPageState();
}

class _MobiusStripPageState extends State<MobiusStripPage> {
  Color c1 = const Color(0xFF8151C0);
  Color c2 = const Color(0xFF42236B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [c2, c1],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: AnimatedRotation(
                turns: 3,
                alignment: Alignment.center,
                duration: const Duration(milliseconds: 2000),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipPath(
                      clipper: const HoleClipper(),
                      child: MobiusRing(c1: c1, c2: c2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ClipPath(
                        clipper: const HoleClipper(),
                        child: MobiusRing2(c1: c1, c2: c2),
                      ),
                    ),
                    ClipPath(
                      clipper: const HalfClipper(),
                      child: ClipPath(
                        clipper: const HoleClipper(),
                        child: MobiusRing(c1: c1, c2: c2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: ColoredBox(
                color: Colors.black.withOpacity(0.4),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    titlePadding: const EdgeInsets.all(0),
                                    contentPadding: const EdgeInsets.all(0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                    ),
                                    content: SingleChildScrollView(
                                      child: SlidePicker(
                                        pickerColor: c1,
                                        onColorChanged: (value) => setState(() {
                                          c1 = value;
                                        }),
                                        enableAlpha: false,
                                        displayThumbColor: true,
                                        showParams: true,
                                        showIndicator: true,
                                        indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: c1,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  titlePadding: const EdgeInsets.all(0),
                                  contentPadding: const EdgeInsets.all(0),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(25)),
                                  ),
                                  content: SingleChildScrollView(
                                    child: SlidePicker(
                                      pickerColor: c2,
                                      onColorChanged: (value) => setState(() {
                                        c2 = value;
                                      }),
                                      enableAlpha: false,
                                      displayThumbColor: true,
                                      showParams: true,
                                      showIndicator: true,
                                      indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: c2,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MobiusRing extends StatelessWidget {
  const MobiusRing({
    super.key,
    required this.c1,
    required this.c2,
  });

  final Color c1;
  final Color c2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scaleX: 2.1,
          scaleY: 0.9,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: c1,
              // gradient: LinearGradient(colors: [c1, c2]),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MobiusRing2 extends StatelessWidget {
  const MobiusRing2({
    super.key,
    required this.c1,
    required this.c2,
  });

  final Color c1;
  final Color c2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.scale(
          scaleX: 2.1,
          scaleY: 0.9,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: c2,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HoleClipper extends CustomClipper<Path> {
  const HoleClipper({
    this.holeRadiusRatio = 0.5,
  });

  final double holeRadiusRatio;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(-55, 0, size.width * 2.1, size.height * 1));

    final holeSize = min(size.width, size.height) * holeRadiusRatio;
    path.addOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: holeSize + 65,
        height: holeSize,
      ),
    );

    return path;
  }

  @override
  bool shouldReclip(covariant HoleClipper oldClipper) => false;
}

class HalfClipper extends CustomClipper<Path> {
  const HalfClipper();

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(Rect.fromLTWH(-55, 0, size.width * 1.05, size.height * 1));

    return path;
  }

  @override
  bool shouldReclip(covariant HalfClipper oldClipper) => false;
}
