import 'package:ego_visionn/cart/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // All cart
  List<Map<String, dynamic>> _carts = [];
  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _carts = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

////// Text(_carts[index]['image']); NetworkImage(
  // 'http://egovision24.com/uploads/product/${_carts[index]['image']}'),/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: _carts.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: Image.network(
                      'http://egovision24.com/uploads/product/${_carts[index]['image']}'),
                ),
                Column(
                  children: [
                    
                  ],
                )
              ],
            );
            // Text(_carts[index]['image']);
            // Image(
            //   height: 100,
            //   width: 100,
            //   image: NetworkImage(
            //       'http://egovision24.com/uploads/product/${_carts[index]['image']}'),
            // );
          }),
    );
  }
}
