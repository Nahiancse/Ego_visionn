import 'dart:async';
import 'dart:convert';

import 'package:ego_visionn/apis/api.dart';
import 'package:ego_visionn/screens/login_screen.dart';
import 'package:ego_visionn/screens/profile.dart';
import 'package:ego_visionn/widgets/bottomNav.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChangePassScreen extends StatefulWidget {
  var id;
  ChangePassScreen({this.id});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final _formKey = GlobalKey<FormState>();
  // var rememberValue = false;
  final TextEditingController oldPassController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF7859a5),
        centerTitle: true,
        title: Text(
          'Change Password',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Column(
                children: [
                  TextFormField(
                    controller: oldPassController,
                    // validator: (value) => EmailValidator.validate(value!)
                    //     ? null
                    //     : "Please enter a valid ID",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter your old password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Old Password',
                      hintStyle: TextStyle(color: Colors.purple, fontSize: 15),
                      // prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    // onSaved: (val) {
                    //           id = val!;
                    //         },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: newPassController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter new password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    // obscureText: true,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Icons.lock),
                      hintText: 'New Password',
                      hintStyle: TextStyle(color: Colors.purple, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: confPassController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'retype new password';
                      }
                      return null;
                    },
                    maxLines: 1,
                    // obscureText: true,
                    decoration: InputDecoration(
                      // prefixIcon: const Icon(Icons.lock),
                      hintText: 'Retype New Password',
                      hintStyle: TextStyle(color: Colors.purple, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // CheckboxListTile(
            //   title: const Text("Remember me"),
            //   contentPadding: EdgeInsets.zero,
            //   value: rememberValue,
            //   activeColor: Theme.of(context).colorScheme.primary,
            //   onChanged: (newValue) {
            //     setState(() {
            //       rememberValue = newValue!;
            //     });
            //   },
            //   controlAffinity: ListTileControlAffinity.leading,
            // ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  print('object');
                  login(widget.id, confPassController.text);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 120,
                color: Colors.purple,
                child: const Text(
                  'Save',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  login(id, password) async {
    Map data = {'id': id, 'password': password};
    print(data.toString());
    final response = await http.post(Uri.parse(UPDATE),
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

      // Map<String, dynamic> user = resposne['user'];
      print(resposne);
      // print(" User name ${user['name']}");
      if (resposne['success'] == 'success') {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
        print(" ${resposne['success']}");

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
}
