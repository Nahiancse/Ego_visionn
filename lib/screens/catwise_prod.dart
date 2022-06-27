import 'package:ego_visionn/democart/dddetail.dart';
import 'package:ego_visionn/models/catwiseProdModel.dart';
 
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
  // This list holds the data for the list view
  List _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = widget.resposne!.contents!;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = widget.resposne!.contents!;
    } else {
      results = widget.resposne!.contents!
          .where((user) => user.productName!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.purple,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      autofocus: true,
                      onChanged: (value) => _runFilter(value),
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          labelText: 'Search',
                          suffixIcon: Icon(Icons.search)),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                _foundUsers.isNotEmpty
                      ?Container(
                  height: 1000,
                  child: GridView.builder(
                      itemCount: _foundUsers.length,
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
                              _foundUsers[index].image! != '' 
                                  ? Image.network(
                                      'http://egovision24.com/uploads/product/${ _foundUsers[index].image!}',
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
                                _foundUsers[index].productName!,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '${_foundUsers[index].productSellingPrice}Tk',
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
                                    return DProdDetailScreen(
                                      prodId: _foundUsers[index].productSlNo,
                                      image:_foundUsers[index].image ,
                                      name: _foundUsers[index].productName,
                                      status:_foundUsers[index].status ,
                                      price: _foundUsers[index].productSellingPrice,
                                      purchasePrice:_foundUsers[index].productPurchaseRate ,
                                      index: index,
                                      );
                                      // return ProdDetailScreen(
                                      // prodId: _foundUsers[index].productSlNo,
                                      // image:_foundUsers[index].image ,
                                      // name: _foundUsers[index].productName,
                                      // status:_foundUsers[index].status ,
                                      // price: _foundUsers[index].productSellingPrice,
                                      // purchasePrice:_foundUsers[index].productPurchaseRate ,
                                      // );
                                      
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
                ): const Text(
                          'No results found',
                          style: TextStyle(fontSize: 24),
                        ),
              ],
            ),
          ),
        ));
  }
}
