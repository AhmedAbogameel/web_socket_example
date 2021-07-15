import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_example/views/chat/view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    Timer(Duration(seconds: 2),()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ChatView(),)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Icon(CupertinoIcons.chat_bubble_fill,color: Colors.blue,size: 200,),
      ),
    );
  }
}
