import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RecievedOrder extends StatefulWidget {
  const RecievedOrder({Key? key}) : super(key: key);

  @override
  State<RecievedOrder> createState() => _RecievedOrderState();
}

class _RecievedOrderState extends State<RecievedOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
backgroundColor: Color(0xFF7859a5),
        centerTitle: true,
        title: Text('Recieved Orders',style: TextStyle(color: Colors.white),),
      ),
    );
  }
}
