import 'dart:async';
import 'dart:convert';

import 'package:ego_visionn/apis/api.dart';
import 'package:ego_visionn/widgets/bottomNav.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AfterOtpPass extends StatefulWidget {
  const AfterOtpPass({Key? key}) : super(key: key);

  @override
  State<AfterOtpPass> createState() => _AfterOtpPassState();
}

class _AfterOtpPassState extends State<AfterOtpPass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController loginPassController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Set Password',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.purple),
          ),
          const SizedBox(
            height: 60,
          ),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: loginPassController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Icons.lock),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.purple, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        print('object');
                        login(loginPassController.text);
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: 120,
                      color: Colors.purple,
                      child: const Text(
                        'Confirm',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  login(password) async {
    Map data = {'password': password};
    print(data.toString());
    final response = await http.post(Uri.parse(OTP),
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
      // print(" User name ${user['name']}");
      if (user['success'] == true) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
      }

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => BottomNav()));

      print(" ${resposne['success']}");

      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
    } else {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
}
