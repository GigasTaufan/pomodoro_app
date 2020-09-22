import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CountDownTimer(),
  ));
}

class CountDownTimer extends StatefulWidget {
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  double percent = 0;
  static int timeInMinute = 25;
  int timeInSec = timeInMinute * 60;

  Timer timer;
  _startTimer() {
    timeInMinute = 25;
    int time = timeInSec;
    double secPercent = (time / 100.0);
    print(secPercent);
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (time > 0) {
          time--;
          if (time % 60 == 0) {
            timeInMinute--;
          }
          if (time % secPercent == 0) {
            if (percent < 1) {
              percent += 0.01;
            } else {
              percent = 1;
            }
          }
        } else {
          percent = 0;
          timeInMinute = 25;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xFFE65100), Color(0xFFFFA726)],
            begin: FractionalOffset(0.3, 1),
          )),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  "Pomodoro",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                  ),
                ),
              ),
              Expanded(
                child: CircularPercentIndicator(
                  percent: percent,
                  animation: true,
                  lineWidth: 20.0,
                  animateFromLastPercent: true,
                  radius: 250.0,
                  reverse: false,
                  progressColor: Colors.white,
                  center: Text(
                    "$timeInMinute",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Productivity Timer",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "25",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      "Pause Timer",
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "5",
                                      style: TextStyle(
                                        fontSize: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 28.0),
                          child: RaisedButton(
                            color: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                "Start",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                            onPressed: _startTimer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
