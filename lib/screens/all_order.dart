import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({Key? key}) : super(key: key);

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFF7859a5),
          centerTitle: true,
          title: Text(
            'All Order',
            style: TextStyle(color: Colors.white),
          )),
    );
  }
}
