import 'package:ego_visionn/screens/home.dart';
import 'package:ego_visionn/screens/profile.dart';
import 'package:ego_visionn/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    ProfileScreen(),
    Home(),
    Home(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  var _savedName;
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
                _savedUserId != null ? Text(_savedName) : Text(''),
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
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
}
