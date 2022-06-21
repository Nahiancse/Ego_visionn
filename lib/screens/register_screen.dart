import 'package:ego_visionn/apis/api.dart';

import 'package:ego_visionn/screens/home.dart';
import 'package:ego_visionn/screens/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'otp/otp_screen.dart';
import 'register_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  final TextEditingController signUpIdController = TextEditingController();
  final TextEditingController signUpEmailController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late String id, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Registration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: TextFormField(
                  //         validator: (value) => EmailValidator.validate(value!)
                  //             ? null
                  //             : "Please enter a valid email",
                  //         maxLines: 1,
                  //         decoration: InputDecoration(
                  //           hintText: 'First name',
                  //           prefixIcon: const Icon(Icons.person),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Expanded(
                  //       child: TextFormField(
                  //         validator: (value) => EmailValidator.validate(value!)
                  //             ? null
                  //             : "Please enter a valid email",
                  //         maxLines: 1,
                  //         decoration: InputDecoration(
                  //           hintText: 'Last name',
                  //           prefixIcon: const Icon(Icons.person),
                  //           border: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: signUpIdController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ID';
                      }
                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type your id',
                      // prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // TextFormField(
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your password';
                  //     }
                  //     return null;
                  //   },
                  //   maxLines: 1,
                  //   obscureText: true,
                  //   decoration: InputDecoration(
                  //     prefixIcon: const Icon(Icons.lock),
                  //     hintText: 'Enter your password',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //   ),
                  // ),
                  TextFormField(
                    controller: signUpEmailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mail';
                      }
                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Type your e-mail',
                      // prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('object');
                        registration(signUpIdController.text,
                            signUpEmailController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Registration',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Have an account'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  registration(id, email) async {
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

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreen(
                    mmail: email,id: id,
                  )));

      print(" ${user['success']}");

      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("${user['message']}")));
    } else {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
}
