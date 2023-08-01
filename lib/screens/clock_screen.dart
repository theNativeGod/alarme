import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({super.key});

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? timer;

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var clockSize = const Size(240, 240);
    var dateTime = DateTime.now();
    var hour = dateTime.hour;
    var min = dateTime.minute;
    var meridian = hour > 12 ? 'PM' : 'AM';

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.grey.shade300,
      drawer: Drawer(
          backgroundColor: Colors.deepPurple.shade50, child: Container()),
      bottomNavigationBar: BottomAppBar(
        elevation: 3.0,
        padding: EdgeInsets.zero,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: (MediaQuery.of(context).size.width - 48) / 2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(3, 3),
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                    const BoxShadow(
                      color: Colors.white70,
                      offset: Offset(-3, -3),
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
              Container(
                height: 60,
                width: (MediaQuery.of(context).size.width - 48) / 2,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(3, 3),
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                    const BoxShadow(
                      color: Colors.white70,
                      offset: Offset(-3, -3),
                      spreadRadius: 3,
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        _scaffoldKey.currentState!.openDrawer();
                      },
                      child: MenuIcon()),
                  const HeadingText(),
                ],
              ),
              ClockAndTextWidget(
                  clockSize: clockSize,
                  hour: hour,
                  min: min,
                  meridian: meridian),
              Text('', style: TextStyle(fontSize: 36)),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuIcon extends StatelessWidget {
  MenuIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.keyboard_arrow_right_rounded,
      size: 40,
      color: Colors.grey.shade300,
      shadows: [
        BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(3.0, 3.0),
            blurRadius: 12,
            spreadRadius: 3),
        const BoxShadow(
            color: Colors.white70,
            offset: Offset(-3.0, 3.0),
            blurRadius: 6,
            spreadRadius: 3),
      ],
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Alarme".toUpperCase(),
      style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade300,
          shadows: [
            BoxShadow(
                color: Colors.grey.shade500,
                offset: const Offset(3.0, 3.0),
                blurRadius: 12,
                spreadRadius: 3),
            const BoxShadow(
                color: Colors.white70,
                offset: Offset(-3.0, 3.0),
                blurRadius: 6,
                spreadRadius: 3),
          ]),
    );
  }
}

class ClockAndTextWidget extends StatelessWidget {
  const ClockAndTextWidget({
    super.key,
    required this.clockSize,
    required this.hour,
    required this.min,
    required this.meridian,
  });

  final Size clockSize;
  final int hour;
  final int min;
  final String meridian;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CLockWidget(clockSize: clockSize),
        ),
        const SizedBox(height: 32),
        TimeText(hour: hour, min: min, meridian: meridian),
      ],
    );
  }
}

class TimeText extends StatelessWidget {
  const TimeText({
    super.key,
    required this.hour,
    required this.min,
    required this.meridian,
  });

  final int hour;
  final int min;
  final String meridian;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "${hour > 12 ? hour - 12 : hour == 0 ? 12 : hour} : $min    $meridian",
        style: TextStyle(
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade300,
            shadows: [
              BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(3.0, 3.0),
                  blurRadius: 12,
                  spreadRadius: 3),
              const BoxShadow(
                  color: Colors.white70,
                  offset: Offset(-3.0, 3.0),
                  blurRadius: 6,
                  spreadRadius: 3),
            ]),
      ),
    );
  }
}

class CLockWidget extends StatefulWidget {
  const CLockWidget({
    super.key,
    required this.clockSize,
  });

  final Size clockSize;

  @override
  State<CLockWidget> createState() => _CLockWidgetState();
}

class _CLockWidgetState extends State<CLockWidget> {
  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.now();

    return Stack(
      children: [
        Container(
          height: widget.clockSize.height,
          width: widget.clockSize.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            color: Colors.grey.shade300,
            boxShadow: outerShadow,
          ),
          child: Center(
            child: Container(
              height: widget.clockSize.height - 16,
              width: widget.clockSize.width - 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(150),
                color: Colors.grey.shade300,
                boxShadow: innerShadow,
              ),
            ),
          ),
        ),
        // Positioned.fill(
        //   child: Transform.rotate(
        //     angle: dateTime.second * 6 * pi / 180,
        //     child: Container(
        //       alignment: AlignmentDirectional(
        //           dateTime.second * 6 * pi / 180 > 3 ? -0.1 : 0.1, 0.45),
        //       child: Container(
        //         height: 112,
        //         width: 6,
        //         decoration: BoxDecoration(
        //           color: Colors.grey.shade400,
        //           borderRadius: BorderRadius.circular(4),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        Positioned.fill(
          child: Transform.rotate(
            angle: dateTime.second * 6 * pi / 180,
            child: Container(
              alignment: const AlignmentDirectional(0.0, 0.4),
              child: Container(
                height: 108,
                width: 6,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Transform.rotate(
            angle: dateTime.minute * 6 * pi / 180 + pi,
            child: Container(
              alignment: const AlignmentDirectional(0.0, 0.32),
              child: Container(
                height: 96,
                width: 8,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Transform.rotate(
            angle: dateTime.hour * 30 * pi / 180 + pi,
            child: Container(
              alignment: const AlignmentDirectional(0.0, 0.2),
              child: Container(
                height: 64,
                width: 10,
                decoration: BoxDecoration(
                  color: Colors.pink,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: ClockCenterWidget(clockSize: widget.clockSize))
      ],
    );
  }

  List<BoxShadow> get innerShadow {
    return [
      BoxShadow(
        color: Colors.grey.shade400,
        offset: const Offset(3, 3),
        spreadRadius: 6,
        blurRadius: 12,
        inset: true,
      ),
      const BoxShadow(
        color: Colors.white70,
        offset: Offset(-3, -3),
        spreadRadius: 3,
        blurRadius: 6,
        inset: true,
      ),
    ];
  }

  List<BoxShadow> get outerShadow {
    return [
      BoxShadow(
        color: Colors.grey.shade500,
        offset: const Offset(3, 3),
        spreadRadius: 3,
        blurRadius: 6,
      ),
      const BoxShadow(
        color: Colors.white70,
        offset: Offset(-3, -3),
        spreadRadius: 3,
        blurRadius: 6,
      ),
    ];
  }
}

class ClockCenterWidget extends StatelessWidget {
  const ClockCenterWidget({
    super.key,
    required this.clockSize,
  });

  final Size clockSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: clockSize.height - 230,
        width: clockSize.width - 230,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(3, 3),
              spreadRadius: 6,
              blurRadius: 12,
            ),
            const BoxShadow(
              color: Colors.white70,
              offset: Offset(-3, -3),
              spreadRadius: 3,
              blurRadius: 6,
            ),
          ],
        ),
      ),
    );
  }
}
