import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'main.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(Post());

class Post extends StatefulWidget {
  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  num position = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
      index: position,
      children: <Widget>[

      WebView(initialUrl: "https://linkam.ng/posts/create",
      javascriptMode: JavascriptMode.unrestricted,
      onPageStarted: (value){setState(() {
        position = 1;
      });},
      onPageFinished: (value){setState(() {
        position = 0;
      });},
      ),
      Container(child: Center(child: CircularProgressIndicator() ,)
      )
      ],
      )
    );
  }
}