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
  var _savedOrganaization;
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
      _savedName = prefs.getString('name');
      _savedPhone = prefs.getString('phone');
      _savedAddress = prefs.getString('address');
      _savedOrganaization = prefs.getString('organization');
      _savedUserId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
            ),
            Card(
              child: Container(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                margin: EdgeInsets.only(left: 30, right: 30,top:30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      width: double.infinity,
                      height: 40,
                      child: Text('Info',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      color: Color(0xFF7859a5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('User Name'),
                        SizedBox(width: 100),
                        Text(_savedName!),
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
                        Text(''),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('UserId'),
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
                        Text('Organization'),
                        SizedBox(width: 100),
                        Text(_savedOrganaization),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
