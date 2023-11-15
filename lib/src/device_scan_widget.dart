import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'animated_circle.dart';

enum NodeType { all, even, odd }

class DeviceScanWidget extends StatefulWidget {
  int layers;
  final double gap;
  final NodeType? nodeType;
  final Color? ringColor;
  final double ringThickness;
  final Color? scanColor;
  final Color? nodeColor;
  final Color? centerNodeColor;
  final Function()? onInitialize;
  final Duration duration;
  final Duration newNodesDuration;
  final bool hideNodes;

  DeviceScanWidget(
      {super.key,
      this.layers = 4,
      this.gap = 30,
      this.nodeType,
      this.nodeColor,
      this.scanColor,
      this.ringColor,
      this.ringThickness = 1,
      this.centerNodeColor,
      this.onInitialize,
      this.duration = const Duration(milliseconds: 1200),
      this.newNodesDuration = const Duration(seconds: 3), this.hideNodes = false}) {
    layers = layers + 1;
  }

  @override
  State<DeviceScanWidget> createState() => _DeviceScanWidgetState();
}

class _DeviceScanWidgetState extends State<DeviceScanWidget>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late Animation opacity;
  late AnimationController animationController;
  late List<int> angles;
  late List<bool> showOnCircles;
  Random random = Random();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    widget.onInitialize?.call();
    if(widget.hideNodes) {
      showOnCircles = List.generate(widget.layers, (index) => false);
    } else {
      switch (widget.nodeType) {
      case NodeType.even:
        showOnCircles = List.generate(widget.layers, (index) => index % 2 == 0);
        break;
      case NodeType.odd:
        showOnCircles = List.generate(widget.layers, (index) => index % 2 != 0);
        break;
      default:
        showOnCircles = List.generate(widget.layers, (index) => true);
        break;
    }
    }
    angles =
        List.generate(widget.layers, (index) => random.nextInt(360)).toList();
    timer = Timer.periodic(widget.newNodesDuration, (timer) {
      angles =
          List.generate(widget.layers, (index) => random.nextInt(360)).toList();
    });
    animationController =
        AnimationController(vsync: this, duration: widget.duration);
    opacity = Tween<double>(begin: 0.8, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeIn));
    animation = Tween<double>(
            begin: 0, end: (widget.gap * widget.layers) - widget.gap / 2)
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.easeInOutQuad))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          widget.onInitialize?.call();
          animationController.repeat();
        }
      });
    animationController.forward();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: CustomPaint(
        painter: AnimatedCircle(
            value: animation.value,
            layers: widget.layers,
            angles: angles,
            showOnCircles: showOnCircles,
            opacity: opacity.value,
            centerNodeColor:
                widget.centerNodeColor ?? Colors.black.withOpacity(0.5),
            ringThickness: widget.ringThickness,
            ringColor: widget.ringColor ?? Colors.grey,
            nodeColor: widget.nodeColor ?? Colors.green,
            scanColor: widget.scanColor ?? Colors.lightGreenAccent,
            gap: widget.gap),
      ),
    );
  }
}
