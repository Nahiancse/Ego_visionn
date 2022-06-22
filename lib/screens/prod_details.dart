import 'package:badges/badges.dart';
 
import 'package:ego_visionn/constants.dart';
import 'package:ego_visionn/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProdDetailScreen extends StatefulWidget {
  String? image;
  String? name;
  String? price;
  String? status;
  int? index;
  ProdDetailScreen(
      {this.name, this.image, this.price, this.status, this.index});

  @override
  State<ProdDetailScreen> createState() => _ProdDetailScreenState();
}

class _ProdDetailScreenState extends State<ProdDetailScreen> {
  int selectedImage = 0;
  late var im = [
    'http://egovision24.com/uploads/product/${widget.image}',
    // 'http://egovision24.com/uploads/product/${widget.image}',
    // 'https://images.unsplash.com/photo-1444464666168-49d633b86797?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmlyZHxlbnwwfHwwfHw%3D&w=1000&q=80',
    // 'https://www.thesprucepets.com/thmb/63v75VJoGecxMB4re_KfA4GYZwc=/2400x2400/smart/filters:no_upscale()/popular-small-bird-species-390926-hero-d3d0af7bb6ed4947b0c3c5afb4784456.jpg'
  ];

  /////////////////////////////////////
   

  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
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
            
          ],
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
