import 'dart:async';

import 'package:ego_visionn/cart/cart_screen.dart';
import 'package:ego_visionn/screens/all_order.dart';
import 'package:ego_visionn/screens/home.dart';
import 'package:ego_visionn/screens/login_screen.dart';
import 'package:ego_visionn/screens/pending_order.dart';
import 'package:ego_visionn/screens/profile.dart';

import 'package:ego_visionn/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  StreamSubscription? internetconnection;
  bool isoffline = false;

  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    Home(),
    PendingOrderScreen(),
    FCartScreen(),
    AllOrderScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (_savedUserId == null) {
        _selectedIndex = 0;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "Please Login",
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            textColor: Colors.white,
            label: 'Login',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
            },
          ),
        ));
        // _widgetOptions[2] = FCartScreen();
      } else {
        // _widgetOptions[0] = Home();
        // _widgetOptions[1] = Home();
        // _widgetOptions[2] = FCartScreen();
        // _widgetOptions[3] = Home();
        // _widgetOptions[4] = ProfileScreen();
      }
    });
  }

  var _savedName;
  // var _savedAddress;
  // var _savedOrganaization;
  var _savedUserId;
  // Retrieve the saved name if it exists
  @override
  void initState() {
    internetconnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // whenevery connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isoffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isoffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isoffline = false;
        });
      }
    }); // using this listiner, you can get the medium of connection as well.

    super.initState();
    _retrieveName();
  }

  @override
  dispose() {
    super.dispose();
    internetconnection!.cancel();
    //cancel internent connection subscription after you are done
  }

  Future<void> _retrieveName() async {
    final prefs = await SharedPreferences.getInstance();

    // Check where the name is saved before or not
    // if (!prefs.containsKey('name')) {
    //   return;
    // }

    setState(() {
      _savedUserId = prefs.getString('userId')!;
      _savedName = prefs.getString('name')!;
      // _savedPhone = prefs.getString('phone');
      // _savedAddress = prefs.getString('address');
      // _savedOrganaization = prefs.getString('organization');
      // _savedUserId = prefs.getString('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: OpenDrawer(),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                _savedUserId != null
                    ? Text(
                        'Due:12500',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    : Text(''),
                SizedBox(
                  width: 30,
                ),
                _savedUserId != null
                    ? Text(
                        _savedName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      )
                    : Text(''),
                _savedUserId != null
                    ? CircleAvatar(
                        backgroundImage: AssetImage('assets/propic.jpg'),
                      )
                    : Text(''),
              ],
            ),
          )
        ],
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                size: 30,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        backgroundColor: Color(0xFF7859a5),
        title: Text(
          'Ego Vision',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: isoffline == false
          ? Center(
              child: _widgetOptions.elementAt(_selectedIndex),
            )
          : Center(child: Text('No Internet')),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF7859a5),
        unselectedItemColor: Colors.grey[600],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_checkout_sharp),
            label: 'Pending',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box_outlined,
              color: Colors.grey,
            ),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget errmsg(String text, bool show) {
    //error message widget.
    if (show == true) {
      //if error is true then show error message box
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.white),
          ), // icon for error message

          Text(text, style: TextStyle(color: Colors.white)),
          //show error message text
        ]),
      );
    } else {
      return Container();
      //if error is false, return empty container.
    }
  }
}
