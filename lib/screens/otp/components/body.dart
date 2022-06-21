import 'package:flutter/material.dart';

import 'otp_form.dart';

import 'package:ego_visionn/apis/api.dart';

import 'package:ego_visionn/screens/login_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  Body({this.mmail, this.id});
  String? mmail;
  String? id;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              // Text("We sent your code to +1 898 860 ***"),
              buildTimer(),
              OtpForm(mmail: widget.mmail),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                  resend(widget.id, widget.mmail);
                },
                child: Text(
                  "Resend oo Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 120.0, end: 0.0),
          duration: Duration(seconds: 120),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Color(0xFFFF7643)),
          ),
        ),
      ],
    );
  }

  resend(id, email) async {
    Map data = {'customerId': id, 'email': email};
    print(data.toString());
    final response = await http.post(Uri.parse(REGISTRATION),
        // headers: {
        //   "Accept": "application/json",
        //   "Content-Type": "application/x-www-form-urlencoded"
        // },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // setState(() {
    //   isLoading=false;
    // });
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);

      Map<String, dynamic> user = resposne;
      print(resposne);
      print("User name ${user['message']}");
      // savePref(1,user['name'],user['email'],user['id']);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => OtpScreen(
      //               mmail: email,
      //             )));

      print(" ${user['success']}");
    } else {}
  }
}
