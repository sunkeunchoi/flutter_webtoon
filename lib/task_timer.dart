import 'dart:async';

import 'package:flutter/material.dart';

class TaskTimer extends StatefulWidget {
  const TaskTimer({super.key});

  @override
  State<TaskTimer> createState() => _TaskTimer();
}

const Color kPrimaryColor = Color(0xffd55846);
const List<int> timerPicker = [15, 20, 25, 30, 35];

class _TaskTimer extends State<TaskTimer> {
  late final ScrollController _controller = ScrollController();
  int selectedIndex = 2;
  int maxTicker = 0;
  int rounds = 0;
  int goals = 0;
  int maxGoals = 12;
  int maxRounds = 4;
  bool isRunning = false;
  bool isBreak = false;
  int currentTick = 0;
  int breakTicker = 5 * 60;
  late int minutes;
  late int seconds;
  late Timer timer;

  void completed() {
    if (rounds < maxRounds - 1) {
      rounds += 1;
    } else {
      goals += 1;
      rounds = 0;
      onBreak();
    }
    setState(() {});
  }

  void resetValues() {
    setState(() {
      isRunning = false;
      isBreak = false;
      maxTicker = timerPicker[selectedIndex] * 60;
      currentTick = 0;
      minutes = maxTicker ~/ 60;
      seconds = maxTicker - (minutes * 60);
    });
  }

  void runTicker() {
    setState(() {
      currentTick += 1;
      minutes = (maxTicker - currentTick) ~/ 60;
      seconds = maxTicker - (minutes * 60) - currentTick;
    });
  }

  void runBreak() {
    setState(() {
      currentTick += 1;
      minutes = (breakTicker - currentTick) ~/ 60;
      seconds = breakTicker - (minutes * 60) - currentTick;
    });
  }

  void onBreak() {
    isBreak = true;
    currentTick = 0;
    minutes = breakTicker ~/ 60;
    seconds = breakTicker - (minutes * 60);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (breakTicker == timer.tick) {
        timer.cancel();
        resetValues();
      } else {
        runBreak();
      }
    });
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (maxTicker == timer.tick) {
        timer.cancel();
        completed();
        resetValues();
      } else {
        runTicker();
      }
    });
    setState(() {
      isRunning = true;
    });
  }

  void onTap() {
    if (isBreak) return;
    if (isRunning) {
      timer.cancel();
      setState(() {
        isRunning = false;
      });
    } else {
      startTimer();
    }
  }

  @override
  void initState() {
    super.initState();
    resetValues();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Text(
                  'POMOTIMER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            TimerDisplay(
              minutes: minutes,
              seconds: seconds,
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 60,
              child: ListView.separated(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: timerPicker.length,
                separatorBuilder: (context, index) => const SizedBox(
                  width: 17,
                ),
                itemBuilder: (context, index) => Opacity(
                  opacity: selectedIndex == index
                      ? 1
                      : (selectedIndex - index).abs() == 1
                          ? 0.8
                          : 0.4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex != index
                          ? kPrimaryColor
                          : Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.white38,
                        width: 3,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          resetValues();
                        });
                      },
                      child: Center(
                        child: Text(
                          timerPicker[index].toString(),
                          style: TextStyle(
                            color: selectedIndex == index
                                ? kPrimaryColor
                                : Colors.white38,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            height: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 70),
            CircleAvatar(
              backgroundColor: Colors.black54.withOpacity(0.3),
              radius: 50,
              child: IconButton(
                color: Colors.white,
                onPressed: onTap,
                icon: Icon(
                  isBreak
                      ? Icons.play_disabled
                      : isRunning
                          ? Icons.pause
                          : Icons.play_arrow,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(height: 70),
            RoundsDisplay(
              currentRounds: rounds,
              maxRounds: maxRounds,
              currentGoals: goals,
              maxGoals: maxGoals,
            ),
          ],
        ),
      ),
    );
  }
}

class RoundsDisplay extends StatelessWidget {
  final int currentRounds;
  final int maxRounds;
  final int currentGoals;
  final int maxGoals;
  const RoundsDisplay({
    super.key,
    required this.currentRounds,
    required this.maxRounds,
    required this.currentGoals,
    required this.maxGoals,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Column(
          children: [
            Text(
              "$currentRounds/$maxRounds",
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Round".toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
        const Spacer(flex: 2),
        Column(
          children: [
            Text(
              "$currentGoals/$maxGoals",
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "GOAL".toUpperCase(),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
        const Spacer(),
      ],
    );
  }
}

class TimerDisplay extends StatelessWidget {
  final int minutes;
  final int seconds;
  const TimerDisplay({
    super.key,
    required this.minutes,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        NumberCard(number: minutes),
        const Text(
          ":",
          style: TextStyle(
            color: Colors.white38,
            fontSize: 100,
          ),
        ),
        NumberCard(number: seconds),
      ],
    );
  }
}

class NumberCard extends StatelessWidget {
  final int number;
  const NumberCard({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Transform.translate(
              offset: const Offset(5, -5),
              child: Container(
                width: 150,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Transform.translate(
              offset: const Offset(10, -10),
              child: Container(
                width: 140,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            width: 160,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
              ),
              child: Text(
                number.toString().padLeft(2, "0"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 90,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
