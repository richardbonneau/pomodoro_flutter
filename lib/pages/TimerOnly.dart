import 'package:flutter/material.dart';

class TimerOnly extends StatefulWidget {
  @override
  State createState() => new TimerOnlyState();
}

class TimerOnlyState extends State<TimerOnly> {
  int globalHours = 1;
  int globalMinutes = 0;
  int globalSeconds = 0;

  int currentHours = 0;
  int currentMinutes = 0;
  int currentSeconds = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xFF18435A),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          globalHours.toString() +
                              ":" +
                              globalMinutes.toString() +
                              ":" +
                              globalSeconds.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0,
                              fontFamily: 'Roboto Condensed')),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          currentHours.toString() +
                              ":" +
                              currentMinutes.toString() +
                              ":" +
                              currentSeconds.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontFamily: 'Roboto Condensed')),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Current State",
                          style: TextStyle(
                              fontFamily: 'Roboto Condensed',
                              color: Colors.white)),
                    ],
                  )
                ]),
            Column(
              children: <Widget>[
                Container(
                  constraints: BoxConstraints.expand(
                    height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
                  ),
                  color:Colors.white,
                child:Text("hi")
              )],
            )
          ],
        ),
      ),
    );
  }
}
