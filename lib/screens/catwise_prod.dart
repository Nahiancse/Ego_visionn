import 'package:ego_visionn/models/catwiseProdModel.dart';
import 'package:ego_visionn/screens/prod_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CatWiseProdScreen extends StatefulWidget {
  CatwiseProdModel? resposne;
  CatWiseProdScreen({this.resposne});

  @override
  State<CatWiseProdScreen> createState() => _CatWiseProdScreenState();
}

class _CatWiseProdScreenState extends State<CatWiseProdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Ego Vision',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFF7859a5),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
              itemCount: widget.resposne!.contents!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.8),
              itemBuilder: (context, index) {
                return Card(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      widget.resposne!.contents![index].image != ''
                          ? Image.network(
                              'http://egovision24.com/uploads/product/${widget.resposne!.contents![index].image!}',
                              height: 120,
                              // width: 120,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/noprod.jpg',
                              height: 120,
                              // width: 120,
                              fit: BoxFit.cover,
                            ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.resposne!.contents![index].productName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${widget.resposne!.contents![index].productSellingPrice}Tk',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // OutlinedButton(child: Text("Add"), onPressed: () {})
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ProdDetailScreen(
                              index: index,
                              image:widget.resposne!.contents![index].image ,
                              name: widget.resposne!.contents![index].productName,
                              status:widget.resposne!.contents![index].status ,
                              price: widget.resposne!.contents![index].productSellingPrice,);
                          }));
                        },
                        child: Container(
                          height: 40,
                          width: 250,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xFF7859a5), width: 3),
                          ),
                          child: Text(
                            'ADD To Cart',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7859a5)),
                          ),
                        ),
                      )
                      // ElevatedButton(onPressed: () {}, child: Text("Add"))
                    ]));
              }),
        ));
  }
}
