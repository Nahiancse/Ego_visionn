import 'dart:convert';

import 'package:ego_visionn/apis/api.dart';
import 'package:ego_visionn/models/ordMod.dart';
import 'package:ego_visionn/screens/home.dart';
import 'package:ego_visionn/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderSummery extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? purchasePrice;
  String? status;
  String? prodId;
  OrderSummery(
      {this.image,
      this.name,
      this.price,
      this.purchasePrice,
      this.status,
      this.prodId});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
  final TextEditingController noteController = TextEditingController();
  var _savedUserId;
  var _savedBranchId;
  var _savedStatus;
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
      _savedUserId = prefs.getString('Id');
      _savedBranchId = prefs.getString('branchId');
      _savedStatus = prefs.getString('status');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summery'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 3,
                child: ListTile(
                  leading: widget.image != ''
                      ? Image(
                          height: 100,
                          width: 100,
                          image: NetworkImage(
                              'http://egovision24.com/uploads/product/${widget.image}'),
                        )
                      : Image.asset(
                          'assets/noprod.jpg',
                          height: 100,
                          width: 100,
                        ),
                  title: Text(
                    widget.name!,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  subtitle: Text(
                    'Price:${widget.price!}Tk',
                    style: TextStyle(
                        color: Color(0xFF7859a5),
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  child: Text(
                    'Shipping Info',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  margin: EdgeInsets.only(left: 30, right: 30),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sub Total'),
                          SizedBox(width: 100),
                          Text('${widget.price}TK'),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Shipping Cost'),
                          SizedBox(width: 100),
                          Text('0'),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Discount'),
                          SizedBox(width: 100),
                          Text('0'),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total'),
                          SizedBox(width: 100),
                          Text('${widget.price!}TK'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  child: TextField(
                      controller: noteController,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Note')),
                ),
              ),
              InkWell(
                onTap: () {
                  login(
                    widget.prodId,
                    widget.price,
                    widget.purchasePrice,
                    1,
                    widget.price,
                    widget.status,
                    _savedUserId,
                    2020,
                    _savedStatus,
                    noteController.text,
                    widget.price,
                    _savedBranchId,
                  );
                },
                child: Card(
                  child: Container(
                    color: Color(0xFF7859a5),
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    height: 50,
                    alignment: Alignment.center,
                    width: 250,
                    child: Text(
                      'Confirm Order',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  login(prodId, saleRate, purchaseRate, quantity, total, prodStatus, custId,
      orderDate, custStatus, note, subtotal, branchId) async {
    Map data = {
      // 'params': 'hi',
      // 'cart': prodId,

      'cart': [
        // {prodId, saleRate, purchaseRate, quantity, '200', prodStatus}
        {
          // 'product_id': prodId.toString(),
          'product_id': prodId,
          'sale_rate': saleRate,
          'purchase_rate': purchaseRate,
          'quantity': quantity,
          'total': total,
          'status': prodStatus
        }
      ].toString(),
      // 'cart': 'nahian',
      // 'sales': {
      //   custId.toString(),
      //   orderDate,
      //   custStatus,
      //   note,
      //   subtotal,
      //   branchId
      // }.toString(),
      'sales': {
        'customer_id': custId,
        'order_date': orderDate,
        'status': custStatus,
        'note': 'aa',
        'subtotal': subtotal,
        'branch_id': branchId
        // custId, orderDate, custStatus, 'aa', subtotal, branchId
      }.toString()
      // 'sales': datas.toString()
    };
    print(data.toString());
    final response = await http.post(Uri.parse(ORDER),
        // headers: {
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // setState(() {
    //   isLoading=false;
    // });
    if (response.statusCode == 200) {
      // print(resposnes);
      print(response.statusCode);
      // Map<String, dynamic> resposnes = jsonDecode(response.body);
      // if (response.body.isNotEmpty) {
      //   Map<String, dynamic> resposnes = jsonDecode(response.body);
      //   print(resposnes);
      // }

      print(response.body);
      // print(resposnes.toString());

      // // Map<String, dynamic> user = resposne['user'];
      // print(resposnes);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => BottomNav()));
      // print('success');
      // print(" User name ${user['name']}");
      // SharedPreferences preferences = await SharedPreferences.getInstance();

      // preferences.setString("userId", user['code']);
      // preferences.setString("name", user['name']);
      // preferences.setString("phone", user['phone']);
      // preferences.setString("address", user['address']);
      // if(user['organization_name'] != null){
      //     preferences.setString("organization", user['organization_name']);
      // }else{
      //   preferences.setString("organization", '');
      // }

      // preferences.setString("image", user['image']);
      // preferences.setString("status", user['status']);
      // preferences.setString("branchId", user['branch_id']);
      // preferences.setString("Id", user['id']);
      // preferences.setString("password", user['password']);
      // savePref(
      //   user['code'],
      //   user['name'],
      //   user['phone'],
      //   user['address'],
      //   user['organization_name'],
      //   user['image'],
      //   user['status'],
      //   user['branch_id'],
      //   user['id'],
      //   user['password'],
      // );

      // print(" ${resposne['success']}");

    }
    // print('something');
  }
}
