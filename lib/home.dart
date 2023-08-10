import 'dart:async';

import "package:flutter/material.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const int timeSetting = 1500;
  int totalSeconds = timeSetting;
  late Timer timer; //지금 당장 초기화하지 않고 나중에 초기화하겠다는 의미.
  bool isRunning = false;
  int totalPomodoros = 0;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros += 1;
        isRunning = false;
        totalSeconds = timeSetting;
      });
      timer.cancel(); // 모든 걸 처음으로 초기화시키는 것.
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  } // Timer가 동작하는 함수

  void onStartPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTick);
    setState(() {
      isRunning = true;
    });
    // 버튼을 누르면 Timer가 작동하고 현재 동작하고 있음을 알기 위해 isRunning을 true로 바꿈.
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
    // 버튼을 누르면 Timer가 멈추고 현재 동작하지 않음을 알기 위해 isRunning을 false로 바꿈.
  }

  String formatTime(int seconds) {
    var duration = Duration(seconds: seconds);
    var formattime = duration
        .toString()
        .split(".")
        .first
        .substring(2, 7); // .을 기준으로 split하여 첫번째 것만 받는다.
    return formattime;
  }

  void reStart() {
    setState(() {
      isRunning = false;
      totalSeconds = timeSetting;
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                formatTime(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 75,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    iconSize: 100,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning
                        ? onPausePressed
                        : onStartPressed, // iconbutton을 눌렀을 때, isRunning의 값에 따라 동작하는 함수가 변화함.
                    icon: Icon(isRunning
                        ? Icons.stop_circle
                        : Icons.play_circle_fill_rounded),
                  ),
                  IconButton(
                      iconSize: 50,
                      color: Theme.of(context).cardColor,
                      onPressed: reStart,
                      icon: const Icon(Icons.restart_alt)),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft:
                            Radius.circular(50), // 선택적으로 borderRadius 넣는 방법
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                        Text(
                          "$totalPomodoros",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color:
                                  Theme.of(context).textTheme.headline1!.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
