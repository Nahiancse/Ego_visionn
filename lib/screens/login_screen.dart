import 'package:ego_visionn/apis/api.dart';

import 'package:ego_visionn/screens/home.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_screen.dart';
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

// Future<LLogin> createAlbum(String phone, String password) async {
//   final response = await http.post(
//     Uri.parse('http://egovision24.com/androidApp/login.php'),
//     // headers: <String, String>{
//     //   'Content-Type': 'application/json; charset=UTF-8',
//     // },
//     body: jsonEncode(<String, String>{'phone': phone, 'password': password}),
//   );

//   if (response.statusCode == 200) {
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.

//       print("successful login");
//       // print(body['PatientID']);
//     return LLogin.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to login');
//   }
// }

// class LLogin {
//   var phone;
//   var password;

//   LLogin({required this.phone, required this.password});

//   factory LLogin.fromJson(Map<String, dynamic> json) {
//     return LLogin(
//       phone: json['phone'],
//       password: json['password'],
//     );
//   }
// }

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);
  // final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // var rememberValue = false;
  final TextEditingController loginIdController = TextEditingController();
  final TextEditingController loginPassController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late String id, password;
  // Future<LLogin>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Customer Login',
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
                  TextFormField(
                    controller: loginIdController,
                    // validator: (value) => EmailValidator.validate(value!)
                    //     ? null
                    //     : "Please enter a valid ID",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ID';
                      }
                      return null;
                    },
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: 'User ID',
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 15),
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
                      hintStyle: TextStyle(color: Colors.white70, fontSize: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Navigator.push(context, MaterialPageRoute(builder: (context){
                        //   return MyNavigationBar();

                        // }));
                        // setState(() {
                        //   _futureAlbum = createAlbum(
                        //       loginIdController.text, loginPassController.text);
                        // });
                        //  _futureAlbum = createAlbum(
                        //       loginIdController.text, loginPassController.text);
                        print('object');
                        login(loginIdController.text, loginPassController.text);
                        // var data = await UserLogin();
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) {
                        //   return Home();
                        // }));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    ),
                    child: const Text(
                      'Login',
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
                      const Text('Don\'t have an account yet?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterPage(title: 'Register UI'),
                            ),
                          );
                        },
                        child: const Text('Registration'),
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

  // Future<Map> UserLogin() async {
  //   // url to registration php script
  //   var APIURL = Uri.parse('http://192.168.0.121:9010/api/login');

  //   //json maping user entered details
  //   Map mapeddate = {
  //     'phone': loginIdController.text,
  //     'password': loginPassController.text,
  //   };
  //   //send  data using http post to our php code

  //   // var response = await http.post(Uri.parse('http://192.168.0.121:9010/api/signup'), body: {'phone': '01914010339', 'username': 'naha','department': 'ortho', 'usertype': '1','password': '123456789'});
  //   var response = await http.post(
  //     APIURL,
  //     body: mapeddate,
  //     headers: {
  //       "Accept": "application/json",
  //       "Content-Type": "application/x-www-form-urlencoded"
  //     },
  //   );

  //   //getting response from php code, here
  //   var data = response.body;
  //   var status = response.statusCode;
  //   // List body=response.body;
  //   print("DATA: $data");
  //   if (status == 200) {
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //   content: Text('Login Successful '),
  //     //   duration: Duration(seconds: 2),
  //     // ));

  //     print("successful login");
  //     // print(body['PatientID']);

  //     // Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //     return jsonDecode(response.body);
  //   }
  //   if (status == 401) {
  //     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //     //   content: Text('Unable to Login,Please Check Again'),
  //     //   duration: Duration(seconds: 5),
  //     // ));
  //     print("unsuccessful login");
  //   }
  //   return jsonDecode(response.body);
  // }

  login(id, password) async {
    Map data = {'phone': id, 'password': password};
    print(data.toString());
    final response = await http.post(Uri.parse(LOGIN),
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

      Map<String, dynamic> user = resposne['user'];
      print(resposne);
      print(" User name ${user['name']}");
      // savePref(1,user['name'],user['email'],user['id']);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));

      print(" ${resposne['success']}");

      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
    } else {
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
  //   savePref(int value, String name, String email, int id) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //     preferences.setInt("value", value);
  //     preferences.setString("name", name);
  //     preferences.setString("email", email);
  //     preferences.setString("id", id.toString());
  //     preferences.commit();

  // }
}
