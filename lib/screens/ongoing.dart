import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnGoingScreen extends StatefulWidget {
  const OnGoingScreen({Key? key}) : super(key: key);

  @override
  State<OnGoingScreen> createState() => _OnGoingScreenState();
}

class _OnGoingScreenState extends State<OnGoingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        automaticallyImplyLeading: false,
backgroundColor: Color(0xFF7859a5),
        centerTitle: true,
        title: Text('OnGoing Orders',style: TextStyle(color: Colors.white),),
      ),
    );
    
  }
}