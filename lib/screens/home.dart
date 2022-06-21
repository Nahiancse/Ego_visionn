import 'dart:ui';

import 'package:ego_visionn/apis/api.dart';
import 'package:ego_visionn/models/brand_model.dart';
import 'package:ego_visionn/models/category_model.dart';
import 'package:ego_visionn/models/catwiseProdModel.dart';
import 'package:ego_visionn/models/color_model.dart';
import 'package:ego_visionn/models/corousel_model.dart';
import 'package:ego_visionn/models/typeModel.dart';
import 'package:ego_visionn/screens/catwise_prod.dart';
import 'package:ego_visionn/widgets/bottomNav.dart';
import 'package:ego_visionn/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;

/////////////////////GET TYPES
Future<Types> fetchAlbum() async {
  final response = await http.get(Uri.parse(TYPE));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Types.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

///////GET CATEGORIES//////////////////////
Future<CategoryModel> fetchCategory() async {
  final response = await http.get(Uri.parse(CATEGORY));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CategoryModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

///////GET BRAND////////////////////////////
Future<BrandModel> fetchBrand() async {
  final response = await http.get(Uri.parse(BRAND));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return BrandModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

////////GET COLOR///////////////////////////////////
Future<ColorModel> fetchColor() async {
  final response = await http.get(Uri.parse(COLOR));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ColorModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

/////////////////GET SLIDER//////////////
Future<CorouselModel> fetchSlider() async {
  final response = await http.get(Uri.parse(SLIDER));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return CorouselModel.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<Types> futureType;
  late Future<CategoryModel> futureCategory;
  late Future<BrandModel> futureBrand;
  late Future<ColorModel> futureColor;
  late Future<CorouselModel> futureSlider;
  int _currentIndex = 0;

  ///FOR SHOWING DOT INDICATOR IN CAROUSEL SLIDER
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    futureType = fetchAlbum();
    futureCategory = fetchCategory();
    futureBrand = fetchBrand();
    futureColor = fetchColor();
    futureSlider = fetchSlider();
  }

  // List cardList = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: OpenDrawer(),
        appBar: AppBar(
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
          backgroundColor: Colors.deepPurple,
          title: Text(
            'Ego Vision',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Types',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<Types>(
                          future: futureType,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: double.infinity,
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.contents!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          type_filter(snapshot
                                              .data!.contents![index].id);
                                        },
                                        child: Container(
                                          width: 135,
                                          height: 100,
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/purpIcon.jpg'),
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  radius: 25,
                                                ),
                                                Text(
                                                  snapshot.data!
                                                      .contents![index].name!,
                                                  style: TextStyle(
                                                      // fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                              // Text(snapshot.data!.);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }),
                    ],
                  ),
                ),
                Text(
                  'Category',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 110,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<CategoryModel>(
                          future: futureCategory,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: double.infinity,
                                height: 110,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.contents!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          type_category(snapshot
                                              .data!
                                              .contents![index]
                                              .productCategorySlNo);
                                        },
                                        child: Container(
                                          width: 135,
                                          height: 100,
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/purpIcon.jpg'),
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  radius: 25,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .contents![index]
                                                      .productCategoryName!,
                                                  style: TextStyle(
                                                      // fontSize: 1,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                              // Text(snapshot.data!.);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }),
                    ],
                  ),
                ),
                Text(
                  'Brand',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<BrandModel>(
                          future: futureBrand,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: double.infinity,
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.contents!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          brand_category(snapshot.data!
                                              .contents![index].brandSiNo);
                                        },
                                        child: Container(
                                          width: 135,
                                          height: 100,
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/purpIcon.jpg'),
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  radius: 25,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .contents![index]
                                                      .brandName!,
                                                  style: TextStyle(
                                                      // fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                              // Text(snapshot.data!.);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }),
                    ],
                  ),
                ),
                Text(
                  'Color',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: double.infinity,
                  height: 110,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FutureBuilder<ColorModel>(
                          future: futureColor,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                width: double.infinity,
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.contents!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          color_category(snapshot.data!
                                              .contents![index].colorSiNo);
                                        },
                                        child: Container(
                                          width: 135,
                                          height: 100,
                                          child: Card(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                CircleAvatar(
                                                  backgroundImage: AssetImage(
                                                      'assets/purpIcon.jpg'),
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                  radius: 25,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .contents![index]
                                                      .colorName!,
                                                  style: TextStyle(
                                                      // fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              );
                              // Text(snapshot.data!.);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          }),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          // border: Border.all(
                          //     // color: Colors.red,
                          //     ),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      height: 200,
                      width: double.infinity,
                      child: CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 100),
                            height: 200,
                            aspectRatio: 5,
                            viewportFraction: 1.0,
                            autoPlayInterval: Duration(seconds: 3),
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                          ),
                          items: [
                            FutureBuilder<CorouselModel>(
                                future: futureSlider,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        width: double.infinity,
                                        // height: 190,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://egovision24.com/uploads/customer/${snapshot.data!.contents![0].image!}',
                                            fit: BoxFit.cover,
                                          ),
                                        )

                                        // ListView.builder(
                                        //     shrinkWrap: true,
                                        //     itemCount: snapshot.data!.contents!.length,
                                        //     scrollDirection: Axis.horizontal,
                                        //     itemBuilder: (context, index) {
                                        //       print(snapshot
                                        //           .data!.contents![index].image!);
                                        //       return Image.network(
                                        //         'http://egovision24.com/uploads/customer/${snapshot.data!.contents![index].image!}',
                                        //         fit: BoxFit.cover,
                                        //       );
                                        //     }),
                                        );
                                    // Text(snapshot.data!.);
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }

                                  // By default, show a loading spinner.
                                  return const Text('');
                                }),
                            FutureBuilder<CorouselModel>(
                                future: futureSlider,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        width: double.infinity,
                                        // height: 190,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://egovision24.com/uploads/customer/${snapshot.data!.contents![1].image!}',
                                            fit: BoxFit.cover,
                                          ),
                                        )

                                        // ListView.builder(
                                        //     shrinkWrap: true,
                                        //     itemCount: snapshot.data!.contents!.length,
                                        //     scrollDirection: Axis.horizontal,
                                        //     itemBuilder: (context, index) {
                                        //       print(snapshot
                                        //           .data!.contents![index].image!);
                                        //       return Image.network(
                                        //         'http://egovision24.com/uploads/customer/${snapshot.data!.contents![index].image!}',
                                        //         fit: BoxFit.cover,
                                        //       );
                                        //     }),
                                        );
                                    // Text(snapshot.data!.);
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }

                                  // By default, show a loading spinner.
                                  return const Text('');
                                }),
                            FutureBuilder<CorouselModel>(
                                future: futureSlider,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        width: double.infinity,
                                        // height: 190,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://egovision24.com/uploads/customer/${snapshot.data!.contents![2].image!}',
                                            fit: BoxFit.cover,
                                          ),
                                        )

                                        // ListView.builder(
                                        //     shrinkWrap: true,
                                        //     itemCount: snapshot.data!.contents!.length,
                                        //     scrollDirection: Axis.horizontal,
                                        //     itemBuilder: (context, index) {
                                        //       print(snapshot
                                        //           .data!.contents![index].image!);
                                        //       return Image.network(
                                        //         'http://egovision24.com/uploads/customer/${snapshot.data!.contents![index].image!}',
                                        //         fit: BoxFit.cover,
                                        //       );
                                        //     }),
                                        );
                                    // Text(snapshot.data!.);
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }

                                  // By default, show a loading spinner.
                                  return const Text('');
                                }),
                            FutureBuilder<CorouselModel>(
                                future: futureSlider,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        width: double.infinity,
                                        // height: 190,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://egovision24.com/uploads/customer/${snapshot.data!.contents![3].image!}',
                                            fit: BoxFit.cover,
                                          ),
                                        )

                                        // ListView.builder(
                                        //     shrinkWrap: true,
                                        //     itemCount: snapshot.data!.contents!.length,
                                        //     scrollDirection: Axis.horizontal,
                                        //     itemBuilder: (context, index) {
                                        //       print(snapshot
                                        //           .data!.contents![index].image!);
                                        //       return Image.network(
                                        //         'http://egovision24.com/uploads/customer/${snapshot.data!.contents![index].image!}',
                                        //         fit: BoxFit.cover,
                                        //       );
                                        //     }),
                                        );
                                    // Text(snapshot.data!.);
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }

                                  // By default, show a loading spinner.
                                  return const Text('');
                                }),
                            FutureBuilder<CorouselModel>(
                                future: futureSlider,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Container(
                                        width: double.infinity,
                                        // height: 190,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            'http://egovision24.com/uploads/customer/${snapshot.data!.contents![4].image!}',
                                            fit: BoxFit.cover,
                                          ),
                                        )

                                        // ListView.builder(
                                        //     shrinkWrap: true,
                                        //     itemCount: snapshot.data!.contents!.length,
                                        //     scrollDirection: Axis.horizontal,
                                        //     itemBuilder: (context, index) {
                                        //       print(snapshot
                                        //           .data!.contents![index].image!);
                                        //       return Image.network(
                                        //         'http://egovision24.com/uploads/customer/${snapshot.data!.contents![index].image!}',
                                        //         fit: BoxFit.cover,
                                        //       );
                                        //     }),
                                        );
                                    // Text(snapshot.data!.);
                                  } else if (snapshot.hasError) {
                                    return Text('${snapshot.error}');
                                  }

                                  // By default, show a loading spinner.
                                  return const Text('');
                                }),
                          ]),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 100,
                      right: 100,
                      child: FutureBuilder<CorouselModel>(
                          future: futureSlider,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: map<Widget>(
                                      snapshot.data!.contents!, (index, url) {
                                    return Container(
                                      width: 15.0,
                                      height: 15.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        shape: BoxShape.circle,
                                        color: _currentIndex == index
                                            ? Colors.white
                                            : Colors.transparent,
                                      ),
                                    );
                                  }));
                              // Text(snapshot.data!.);
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }

                            // By default, show a loading spinner.
                            return const Text('');
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(),
      ),
    );
  }

//type wise products
  type_filter(id) async {
    Map data = {'typeId': id};
    print(data.toString());
    final response = await http.post(Uri.parse(CATWISEPROD),
        // headers: {
        //   "Accept": "application/json",
        //   "Content-Type": "application/x-www-form-urlencoded"
        // },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // setState(() {
    //   isLoading=false;
    // });
    if (response.statusCode == 200) {
      // Map<String, dynamic> resposne = jsonDecode(response.body);
      CatwiseProdModel resposne =
          CatwiseProdModel.fromJson(jsonDecode(response.body));

      // Map<String, dynamic> user = resposne['user'];
      // print(resposne);
      // print(" User name ${user['name']}");
      // // savePref(1,user['name'],user['email'],user['id']);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CatWiseProdScreen(
          resposne: resposne,
        );
      }));

      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
    } else {
      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }

  ///category wise product
  type_category(id) async {
    Map data = {'catId': id};
    print(data.toString());
    final response = await http.post(Uri.parse(CATWISEPROD),
        // headers: {
        //   "Accept": "application/json",
        //   "Content-Type": "application/x-www-form-urlencoded"
        // },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // setState(() {
    //   isLoading=false;
    // });
    if (response.statusCode == 200) {
      // Map<String, dynamic> resposne = jsonDecode(response.body);
      CatwiseProdModel resposne =
          CatwiseProdModel.fromJson(jsonDecode(response.body));

      // Map<String, dynamic> user = resposne['user'];
      // print(resposne);
      // print(" User name ${user['name']}");
      // // savePref(1,user['name'],user['email'],user['id']);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CatWiseProdScreen(
          resposne: resposne,
        );
      }));

      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
    } else {
      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }

  //branwise products
  brand_category(id) async {
    Map data = {'brandId': id};
    print(data.toString());
    final response = await http.post(Uri.parse(CATWISEPROD),
        // headers: {
        //   "Accept": "application/json",
        //   "Content-Type": "application/x-www-form-urlencoded"
        // },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // setState(() {
    //   isLoading=false;
    // });
    if (response.statusCode == 200) {
      // Map<String, dynamic> resposne = jsonDecode(response.body);
      CatwiseProdModel resposne =
          CatwiseProdModel.fromJson(jsonDecode(response.body));

      // Map<String, dynamic> user = resposne['user'];
      // print(resposne);
      // print(" User name ${user['name']}");
      // // savePref(1,user['name'],user['email'],user['id']);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CatWiseProdScreen(
          resposne: resposne,
        );
      }));

      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
    } else {
      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }

  ////colorwise product
  color_category(id) async {
    Map data = {'colorId': id};
    print(data.toString());
    final response = await http.post(Uri.parse(CATWISEPROD),
        // headers: {
        //   "Accept": "application/json",
        //   "Content-Type": "application/x-www-form-urlencoded"
        // },
        body: data,
        encoding: Encoding.getByName("utf-8"));
    // setState(() {
    //   isLoading=false;
    // });
    if (response.statusCode == 200) {
      // Map<String, dynamic> resposne = jsonDecode(response.body);
      CatwiseProdModel resposne =
          CatwiseProdModel.fromJson(jsonDecode(response.body));

      // Map<String, dynamic> user = resposne['user'];
      // print(resposne);
      // print(" User name ${user['name']}");
      // // savePref(1,user['name'],user['email'],user['id']);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return CatWiseProdScreen(
          resposne: resposne,
        );
      }));

      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("${resposne['success']}")));
    } else {
      // scaffoldMessenger
      //     .showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
}
