import 'package:badges/badges.dart';


import 'package:ego_visionn/constants.dart';
import 'package:ego_visionn/cart/cart_model.dart';
import 'package:ego_visionn/cart/cart_provider.dart';
import 'package:ego_visionn/cart/cart_screen.dart';
import 'package:ego_visionn/cart/db_helper.dart';
import 'package:ego_visionn/screens/order_summery.dart';
import 'package:ego_visionn/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
// import 'sql_helper.dart';

class DProdDetailScreen extends StatefulWidget {
  String image;
  String name;
  String price;
  String status;
  String prodId;
  String purchasePrice;
  int index;
  DProdDetailScreen(
      {
    required  this.name,
    required  this.image,
    required  this.price,
    required  this.status,
    required  this.prodId,
    required  this.purchasePrice,
      required this.index});

  @override
  State<DProdDetailScreen> createState() => _ProdDetailScreenState();
}

class _ProdDetailScreenState extends State<DProdDetailScreen> {
  int selectedImage = 0;
  late var im = [
    'http://egovision24.com/uploads/product/${widget.image}',
    // 'http://egovision24.com/uploads/product/${widget.image}',
    // 'https://images.unsplash.com/photo-1444464666168-49d633b86797?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmlyZHxlbnwwfHwwfHw%3D&w=1000&q=80',
    // 'https://www.thesprucepets.com/thmb/63v75VJoGecxMB4re_KfA4GYZwc=/2400x2400/smart/filters:no_upscale()/popular-small-bird-species-390926-hero-d3d0af7bb6ed4947b0c3c5afb4784456.jpg'
  ];

  /////////////////////////////////////cart
  // All cart
  // List<Map<String, dynamic>> _carts = [];
  // bool _isLoading = true;
  // This function is used to fetch all data from the database
  // void _refreshJournals() async {
  //   final data = await SQLHelper.getItems();
  //   setState(() {
  //     _carts = data;
  //     _isLoading = false;
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _refreshJournals(); // Loading the diary when the app starts
  // }

  // void _createCart(int? id) async {
  // if (id != null) {
  //   // id == null -> create new item
  //   // id != null -> update an existing item
  //   final existingJournal =
  //       _carts.firstWhere((element) => element['id'] == id);
  //   if (existingJournal['name'] == widget.name) {
  //     print('already exits');
  //   }
  // }

  //   if (id == null) {
  //     await _addItem();
  //     print('success');
  //     Navigator.push(context, MaterialPageRoute(builder: (context) {
  //       return FCartScreen();
  //       // return CartScreen();
  //     }));
  //     // final existingJournal =
  //     //     _carts.firstWhere((element) => element['id'] == id);
  //     // if (existingJournal['id'] == id) {
  //     //   print('already exits');
  //     // } else if (existingJournal['id'] != id) {

  //     // }
  //   } else {
  //     print('already exist');
  //   }
  // }

/////////////existing item
  // void _existing(int? id) async {
  //   if (id != null) {
  //     // id == null -> create new item
  //     // id != null -> update an existing item
  //     final existingJournal =
  //         _carts.firstWhere((element) => element['id'] == id);
  //     if (existingJournal['id'] == id) {
  //       print('already exits');
  //     }
  //   }
  // }

  // Insert a new journal to the database
  // Future<void> _addItem() async {
  //   await SQLHelper.createItem(
  //     widget.name!,
  //     widget.price!,
  //     widget.image!,
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     content: Text('added to cart'),
  //   ));
  //   _refreshJournals();
  // }

  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // InkWell(
          //   onTap: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => FCartScreen()));
          //   },
          //   child: Center(
          //     child: Badge(
          //       badgeContent: Consumer<CartProvider>(
          //         builder: (context, value, child) {
          //           return Text(value.getCounter().toString(),
          //               style: TextStyle(color: Colors.white));
          //         },
          //       ),
          //       animationDuration: Duration(milliseconds: 300),
          //       animationType: BadgeAnimationType.slide,
          //       child: Icon(Icons.shopping_bag_outlined),
          //     ),
          //   ),
          // ),
          SizedBox(width: 20.0)
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF7859a5),
              size: 30,
            )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: widget.image != ''
                    ? Image.network(im[selectedImage])
                    : Image.asset(
                        'assets/noprod.jpg',
                        // height: 120,
                        // width: 120,
                        fit: BoxFit.cover,
                      ),
              ),
              // SizedBox(height: getProportionateScreenWidth(20)),
              Divider(
                thickness: 1,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(
                        im.length, (index) => buildSmallProductPreview(index)),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Text(
                widget.name!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[700]),
              ),
              SizedBox(
                height: 10,
              ),
              Text('Price : ${widget.price!}Tk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7859a5),
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text('Stock Availability:',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  widget.status == 'a'
                      ? Text('In Stock',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.bold))
                      : Text('Not Available',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.red,
                          ))
                ],
              ),

              /////////////for cart
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      print(widget.index);
                      print(widget.index);
                      print(widget.name.toString());
                      print(double.parse(widget.price!).toString());
                      print(double.parse(widget.price!).toString());
                      print('1');
                      print('kg');
                      print(widget.image.toString());

                      dbHelper!
                          .insert(Cart(
                              id: widget.index,
                              productId: widget.index.toString(),
                              productName: widget.name.toString(),
                              initialPrice: double.parse(widget.price),
                              productPrice: double.parse(widget.price),
                              quantity: 1,
                              unitTag: 'kg',
                              image: widget.image.toString()))
                          .then((value) {
                        cart.addTotalPrice(
                            double.parse(widget.price.toString()));
                        cart.addCounter();

                        final snackBar = SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Product is added to cart'),
                          duration: Duration(seconds: 1),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }).onError((error, stackTrace) {
                        print("error" + error.toString());
                        final snackBar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Product is already added in cart'),
                            duration: Duration(seconds: 1));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    },
                    // () {
                    //         _createCart(null);
                    //       },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      color: Colors.purple,
                      height: 40,
                      width: 150,
                      child: Text(
                        'Add to cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OrderSummery(
                          name: widget.name,
                          image: widget.image,
                          price: widget.price,
                          prodId: widget.prodId,
                          purchasePrice: widget.purchasePrice,
                          status: widget.status,
                        );
                      }));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      color: Colors.green,
                      height: 40,
                      width: 150,
                      child: Text(
                        'Buy Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              /////////////for checkout
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        // padding: EdgeInsets.all(8),
        height: 120,
        // width: 200,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFF7859a5)
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: widget.image != ''
            ? Image.network(im[index])
            : Image.asset(
                'assets/noprod.jpg',
                // height: 120,
                // width: 120,
                fit: BoxFit.cover,
              ),

        // Image.network(
        //   'http://egovision24.com/uploads/product/${widget.image}',
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
