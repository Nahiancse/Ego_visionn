import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class OrderSummery extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  OrderSummery({this.image, this.name, this.price});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery> {
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
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Note')),
                ),
              ),
              InkWell(
                onTap: () {},
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
}
