import 'dart:convert';
import 'dart:io';

import 'package:ego_visionn/apis/api.dart';
import 'package:ego_visionn/widgets/bottomNav.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImUpScreen extends StatefulWidget {
  ImUpScreen({this.id});
  var id;

  @override
  State<ImUpScreen> createState() => _ImUpScreenState();
}

class _ImUpScreenState extends State<ImUpScreen> {
  File? selectedImage;
  var resJson;

  onUploadImage() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(IMUPDATE),
    );
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.fields['id'] = widget.id;
    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage!.readAsBytes().asStream(),
        selectedImage!.lengthSync(),
        filename: selectedImage!.path.split('/').last,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    http.Response response = await http.Response.fromStream(res);
 
      resJson = jsonDecode(response.body);
    
    print(resJson);
     
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.green,
                  content: Text(
                    "Successfully Changed",
                    style: TextStyle(color: Colors.white),
                  ),
                 
                ));
      Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNav()));
           
   
  }

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF7859a5),
        centerTitle: true,
        title: Text(
          'Change Image',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            selectedImage == null
                ? Text(
                    'Please Pick a image to Upload',
                  )
                : Image.file(selectedImage!),
            RaisedButton(
              color: Colors.green[300],
              onPressed: onUploadImage,
              child: Text(
                "Upload",
                style: TextStyle(color: Colors.white),
              ),
            ),
         
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Increment',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
