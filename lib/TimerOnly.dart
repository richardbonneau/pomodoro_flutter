import 'package:flutter/material.dart';

class TimerOnly extends StatefulWidget {
  @override State createState() => new TimerOnlyState();
}

class TimerOnlyState extends State<TimerOnly> {
  int globalHours = 0;
  int globalMinutes = 0;
  int globalSeconds = 0;

  int currentHours = 0;
  int currentMinutes = 0;
  int currentSeconds = 0;


  @override void initState(){
    super.initState();

  }

  @override Widget build(BuildContext context) {

    return new Scaffold(
      backgroundColor: Color(0xFF18435A),
      body: Center(
           child: Text(currentHours.toString()+":"+currentMinutes.toString()+":"+currentSeconds.toString(),
             style: TextStyle(color: Colors.white),),
          ),
    );
  }

}