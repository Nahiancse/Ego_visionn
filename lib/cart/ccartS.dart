import 'package:ego_visionn/cart/sql_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartScreenn extends StatefulWidget {
  const CartScreenn({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreenn> {
  var quantity = 1;
  void _incrementCounter() {
    setState(() {
      quantity++;
    });
  }

  void _decrementCounter() {
    setState(() {
      quantity--;
    });
  }

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

  // Delete an item
  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text('Shopping Cart', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              _carts.isEmpty ?Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage('assets/empty_cart.png'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Your cart is empty 😌',
                            style: Theme.of(context).textTheme.headline5),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            'Explore products and shop your\nfavourite items',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle2)
                      ],
                    ),
                  ):
              // if (_carts.isNotEmpty) {
              //   if (_carts.isEmpty) {
              //     return Align(
              //       alignment: Alignment.center,
              //       child: Column(
              //         children: [
              //           Image(
              //             image: AssetImage('assets/empty_cart.png'),
              //           ),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           Text('Your cart is empty 😌',
              //               style: Theme.of(context).textTheme.headline5),
              //           SizedBox(
              //             height: 20,
              //           ),
              //           Text(
              //               'Explore products and shop your\nfavourite items',
              //               textAlign: TextAlign.center,
              //               style: Theme.of(context).textTheme.subtitle2)
              //         ],
              //       ),
              //     );
              //   } else {
              //     return
              Expanded(
                child: ListView.builder(
                    itemCount: _carts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  _carts[index]['image'] != ''
                                      ? Image(
                                          height: 100,
                                          width: 100,
                                          image: NetworkImage(
                                              'http://egovision24.com/uploads/product/${_carts[index]['image']}'),
                                        )
                                      : Image.asset(
                                          'assets/noprod.jpg',
                                          height: 100,
                                          width: 100,
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _carts[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  _deleteItem(
                                                      _carts[index]['id']);
                                                },
                                                child: Icon(Icons.delete))
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          '${_carts[index]['price']}Tk',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Container(
                                              height: 35,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          if (quantity != 0) {
                                                            _decrementCounter();
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                        )),
                                                    Text('$quantity',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    InkWell(
                                                        onTap: () {
                                                          _incrementCounter();
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              //   Visibility(
              //     visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
              //         ? false
              //         : true,
              //     child: Column(
              //       children: [
              //         ReusableWidget(
              //           title: 'Sub Total',
              //           value: r'$' + value.getTotalPrice().toStringAsFixed(2),
              //         ),
              //         ReusableWidget(
              //           title: 'Discout 5%',
              //           value: r'$' + '20',
              //         ),
              //         ReusableWidget(
              //           title: 'Total',
              //           value: r'$' + value.getTotalPrice().toStringAsFixed(2),
              //         ),
              //         InkWell(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) {
              //       return Checkout(subtotal: value.getTotalPrice().toInt());
              //     }));
              //   },
              //   child: Container(
              //     height: 40,
              //     width: 150,
              //     alignment: Alignment.center,
              //     decoration: BoxDecoration(
              //       color: Colors.black,
              //       borderRadius: BorderRadius.all(Radius.circular(10)),
              //     ),
              //     child: Text(
              //       'Buy Now',
              //       style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),
              //       ],

              //     ),
              //   )
            ])));
  }
}

class ReusableWidget extends StatelessWidget {
  final String title, value;
  const ReusableWidget({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.subtitle2,
          )
        ],
      ),
    );
  }
}
