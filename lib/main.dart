import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Linkam',
      home: Webviewload(),
    );
  }
}


class Webviewload extends StatefulWidget {
  @override
  _WebviewloadState createState() => _WebviewloadState();
}

class _WebviewloadState extends State<Webviewload> {
  num position = 1;
  
  @override
  void initState(){
    super.initState();
    if(Platform.isAndroid)WebView.platform = SurfaceAndroidWebView();
  }

Completer<WebViewController> _controller = Completer<WebViewController>();

  Future<bool> _onWillPop() async{
    WebViewController webViewController = await _controller.future;
    bool canNavigate = await webViewController.canGoBack();
    if(canNavigate){
      webViewController.goBack();
    }else{
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to leave Linkam'),
        actions: <Widget>[
          TextButton(onPressed: () => Navigator.of(context).pop(false), 
          child: new Text('No')
          ),
          TextButton(onPressed: () => Navigator.of(context).pop(true),
          child: new Text('Yes')
          ),
        ],
      ),
    )) ?? false;
  }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Post())
            );
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        body: IndexedStack(
          index: position,
          children: <Widget>[
            WebView(initialUrl: "https://linkam.ng",
        javascriptMode: JavascriptMode.unrestricted,
         onWebViewCreated: (WebViewController webViewController) {
           _controller.complete(webViewController);
        },
        onPageStarted: (value){setState((){
          position = 1;
        });},
        onPageFinished: (value){setState(() {
          position = 0;
        });},
        ),
        Container(
          child: Center(
            child: CircularProgressIndicator()
          )
        )
          ],
        ),
      )
    );
  }
}