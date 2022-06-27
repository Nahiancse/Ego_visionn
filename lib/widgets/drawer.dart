import 'package:ego_visionn/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenDrawer extends StatefulWidget {
  const OpenDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<OpenDrawer> createState() => _OpenDrawerState();
}

class _OpenDrawerState extends State<OpenDrawer> {
  // late ScaffoldMessengerState scaffoldMessenger;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // var _savedName;
  // var _savedAddress;
  // var _savedOrganaization;
  var _savedUserId;
  // Retrieve the saved name if it exists
  @override
  void initState() {
    super.initState();
    _retrieveName();
  }

  Future<void> _retrieveName() async {
    final prefs = await SharedPreferences.getInstance();

    // Check where the name is saved before or not
    // if (!prefs.containsKey('name')) {
    //   return;
    // }

    setState(() {
      _savedUserId = prefs.getString('userId')!;
      // _savedPhone = prefs.getString('phone');
      // _savedAddress = prefs.getString('address');
      // _savedOrganaization = prefs.getString('organization');
      // _savedUserId = prefs.getString('userId');
    });
  }

  Future<void> _clearName() async {
    final prefs = await SharedPreferences.getInstance();
    // Check where the name is saved before or not
    // if (!prefs.containsKey('name')) {
    //   return;
    // }

    await prefs.remove('userId');
    setState(() {
      _savedUserId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // key: _scaffoldKey,
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            // margin: EdgeInsets.only(top: 50),
            // height: double.infinity,
            color: Color(0xFF7859a5),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/propic.jpg'),
                  radius: 35,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Ego Vision',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Pending Order",
              style: TextStyle(
                  color: Color(0xFF7859a5), fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              "Ongoing Order",
              style: TextStyle(
                  color: Color(0xFF7859a5), fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              "Recieve Order",
              style: TextStyle(
                  color: Color(0xFF7859a5), fontWeight: FontWeight.bold),
            ),
            onTap: () {
              // _savedUserId == null
              //     ? scaffoldMessenger
              //         .showSnackBar(SnackBar(content: Text("please login!")))
              //     : Navigator.pop(context);
              // Scaffold.of(context).showSnackBar(snackBar);
            },
          ),
          ListTile(
            title: Text(
              "All Order",
              style: TextStyle(
                  color: Color(0xFF7859a5), fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: _savedUserId == null
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Color(0xFF7859a5),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Want to Logout?"),
                              // content: Text("This is an alert message."),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FlatButton(
                                      child: Text("Cancel"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("OK"),
                                      onPressed: () {
                                        _clearName();
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginPage(),
                                          ),
                                          (route) => false,
                                        );
                                        // Navigator.pushReplacement(context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) {
                                        //   return LoginPage();
                                        // }));

                                        // SystemNavigator.pop();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            );
                          });
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Color(0xFF7859a5),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
            // onTap: () {
            //   _savedUserId != null
            //       ? Navigator.push(context,
            //           MaterialPageRoute(builder: (context) {
            //           return LoginPage();
            //         }))
            //       : AlertDialog(
            //           title: Text("Want to Logout"),
            //           content: Text("This is an alert message."),
            //           actions: [
            //             FlatButton(
            //               child: Text("Cancel"),
            //               onPressed: () {
            //                 Navigator.of(context).pop();
            //               },
            //             ),
            //             FlatButton(
            //               child: Text("OK"),
            //               onPressed: () {
            //                 _clearName;
            //                 Navigator.pushReplacement(context,
            //                     MaterialPageRoute(builder: (context) {
            //                   return LoginPage();
            //                 }));
            //               },
            //             )
            //           ],
            //         );
            // },
          ),
        ],
      ),
    );
  }
}
