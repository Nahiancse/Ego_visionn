import 'package:flutter/material.dart';
// import 'package:shop_app/size_config.dart';

import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  String? mmail;
   String? id;
  OtpScreen({this.mmail,this.id});
  @override
  Widget build(BuildContext context) {
    // SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(mmail: mmail,id: id,),
    );
  }
}
