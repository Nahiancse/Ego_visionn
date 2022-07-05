import 'package:ego_visionn/screens/changePass.dart';
import 'package:ego_visionn/screens/imageUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _savedName;
  var _savedPhone;
  var _savedAddress;
  var _savedArea;
  var _savedOfficer;
  var _savedEmail;
  var _savedOwner;
  var _savedOrganaization;
  var _savedUserId;
  var _savedId;
  var _savedIm;
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
      _savedName = prefs.getString('name');
      _savedPhone = prefs.getString('phone');
      _savedAddress = prefs.getString('address');
      _savedOrganaization = prefs.getString('organization');
      _savedUserId = prefs.getString('userId');
      _savedId = prefs.getString('Id');
      _savedOwner = prefs.getString('ownerName');
      _savedOfficer = prefs.getString('officer');
      _savedArea = prefs.getString('area');
      _savedEmail = prefs.getString('email');
      _savedIm = prefs.getString('image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _savedIm != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(
                              'http://egovision24.com/uploads/customer/${_savedIm}'),
                          radius: 50,
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage('assets/propic.jpg'),
                          radius: 50,
                        )

                  // Positioned(
                  //     bottom: 0,
                  //     right: -10,
                  //     child: IconButton(
                  //         onPressed: () {
                  //           showDialog(
                  //               context: context,
                  //               builder: (context) {
                  //                 return Container(
                  //                   height: 100,
                  //                   width: 100,
                  //                   child: AlertDialog(
                  //                     title: Column(
                  //                       // mainAxisAlignment:
                  //                       //     MainAxisAlignment.center,
                  //                       children: [
                  //                         // Text("This is an alert message."),
                  //                         TextButton(
                  //                             onPressed: () {
                  //                               Navigator.push(context,
                  //                                   MaterialPageRoute(
                  //                                       builder: (context) {
                  //                                 return ImUpScreen(
                  //                                   id: _savedId!,
                  //                                 );
                  //                               }));
                  //                             },
                  //                             child: Text('Upload Image')),
                  //                         TextButton(
                  //                             onPressed: () {
                  //                               Navigator.push(context,
                  //                                   MaterialPageRoute(
                  //                                       builder: (context) {
                  //                                 return ChangePassScreen(
                  //                                   id: _savedId!,
                  //                                 );
                  //                               }));
                  //                             },
                  //                             child: Text('Change Password')),
                  //                       ],
                  //                     ),
                  //                     // content: Column(
                  //                     //   // mainAxisAlignment:
                  //                     //   //     MainAxisAlignment.center,
                  //                     //   children: [
                  //                     //     // Text("This is an alert message."),
                  //                     //     TextButton(
                  //                     //         onPressed: () {},
                  //                     //         child: Text('Upload Image')),
                  //                     //     TextButton(
                  //                     //         onPressed: () {},
                  //                     //         child: Text('Change Password')),
                  //                     //   ],
                  //                     // ),
                  //                   ),
                  //                 );
                  //               });
                  //         },
                  //         icon: Icon(
                  //           Icons.edit,
                  //           size: 35,
                  //         )))
                ],
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: EdgeInsets.only(left: 30, right: 30, top: 15),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        width: double.infinity,
                        height: 40,
                        child: Text(
                          'Info',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Color(0xFF7859a5),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Customer Name'),
                          SizedBox(width: 100),
                          Flexible(child: Text(_savedName!)),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Customer ID'),
                          SizedBox(width: 100),
                          Text(_savedUserId!),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phone'),
                          SizedBox(width: 100),
                          Text(_savedPhone!),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('E-mail'),
                          SizedBox(width: 100),
                          Text(_savedEmail),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Owner Name'),
                          SizedBox(width: 100),
                          Text(_savedOwner!),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Officer Name'),
                          SizedBox(width: 100),
                          Text(_savedOfficer!),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Area'),
                          SizedBox(width: 100),
                          Text(_savedArea),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Address'),
                          SizedBox(width: 100),
                          Text(_savedAddress!),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChangePassScreen(
                      id: _savedId!,
                    );
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 150,
                  color: Color(0xFF7859a5),
                  child: const Text(
                    'Change Password',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ImUpScreen(
                      id: _savedId!,
                    );
                  }));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 150,
                  color: Color(0xFF7859a5),
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
