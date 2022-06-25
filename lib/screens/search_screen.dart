import 'dart:convert';

import 'package:ego_visionn/apis/api.dart';
import 'package:ego_visionn/models/search_model.dart';
import 'package:ego_visionn/screens/prod_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

// Future<SearchModel> fetchSearch() async {
//   final response = await http.get(Uri.parse(SEARCH));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return SearchModel.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }

// }

class SearchScreen extends StatefulWidget {
  SearchModel? resposne;
  SearchScreen({this.resposne});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
        appBar: AppBar(backgroundColor: Color(0xFF7859a5),title: Text('Search',style: TextStyle(color:Colors.white),)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                        color: Colors.white,
              border: Border.all(
                color: Colors.purple,
              ),
              borderRadius: BorderRadius.circular(10.0),),
                  child: TextField(
                    onChanged: (value) => _runFilter(value),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                        labelText: 'Search', suffixIcon: Icon(Icons.search)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _foundUsers.isNotEmpty
                    ? Container(
                        height: 1000,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProdDetailScreen(
                                      name: _foundUsers[index].productName!,
                                      image: _foundUsers[index].image!,
                                      price:
                                          _foundUsers[index].productSellingPrice,
                                      status: 'a',
                                      prodId: _foundUsers[index].productSlNo,
                                      purchasePrice:
                                          _foundUsers[index].productPurchaseRate,
                                    );
                                  }));
                                },
                                child: ListTile(
                                  leading: _foundUsers[index].image! != ''
                                      ? Container(
                                          height: 100,
                                          width: 100,
                                          child: Image.network(
                                              'http://egovision24.com/uploads/product/${_foundUsers[index].image}'),
                                        )
                                      : Image.asset(
                                          'assets/noprod.jpg',
                                          height: 100,
                                          width: 100,
                                        ),
                                  //  _foundUsers[index].image != ''
                                  // ? Image(
                                  //     height: 100,
                                  //     width: 100,
                                  //     image: NetworkImage(
                                  //         'http://egovision24.com/uploads/product/${_foundUsers[index].image}'),
                                  //   )
                                  // : Image.asset(
                                  //     'assets/noprod.jpg',
                                  //     height: 100,
                                  //     width: 100,
                                  //   ),
                                  title: Text(_foundUsers[index].productName!),
                                  subtitle: Text(
                                    '${_foundUsers[index].productSellingPrice}Tk',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              );
                            }),
                      )
                    : const Text(
                        'No results found',
                        style: TextStyle(fontSize: 24),
                      ),
              ],
            ),
          ),
        )

        // FutureBuilder<SearchModel>(
        //   future: futureSearch,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //           shrinkWrap: true,
        //           itemCount: snapshot.data!.contents!.length,
        //           itemBuilder: (context, index) {
        //             return ListTile(
        //               leading: snapshot.data!.contents![index].image != ''
        //                   ? Image(
        //                       height: 100,
        //                       width: 100,
        //                       image: NetworkImage(
        //                           'http://egovision24.com/uploads/product/${snapshot.data!.contents![index].image}'),
        //                     )
        //                   : Image.asset(
        //                       'assets/noprod.jpg',
        //                       height: 100,
        //                       width: 100,
        //                     ),
        //               title: Text(snapshot.data!.contents![index].productName!),
        //               subtitle: Text(
        //                 '${snapshot.data!.contents![index].productSellingPrice}Tk',
        //                 style: TextStyle(color: Colors.black),
        //               ),
        //             );
        //           });
        //     }
        //     return Center(child: CircularProgressIndicator());
        //   },
        // )

        );
  }
}
