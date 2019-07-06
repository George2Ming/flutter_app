import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
const CATCH_URLS = ['m.ctrip.com/','m.ctrip.com/html5/','m.ctrip.com/html5'];
class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView({this.url, this.statusBarColor, this.title, this.hideAppBar,
    this.backForbid});

  @override
  State<StatefulWidget> createState() => _WebViewState();

}

class _WebViewState extends State<WebView>{
  final webviewReference = new FlutterWebviewPlugin();

  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url){

    });
    _onStateChanged = webviewReference.onStateChanged.listen((WebViewStateChanged state){
      switch(state.type){
        case WebViewState.startLoad:

          break;
        default:
          break;
      }
    });
    _onHttpError = webviewReference.onHttpError.listen((WebViewHttpError error){
      print(error);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    // 背景色/返回按钮颜色
    _appBar (Color backgroundColor, Color backButtonColor) {
        if(widget.hideAppBar??false){
          return Container(
            color: backgroundColor,
            height: 30,
          );
        }
        return Container(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.close,
                      color: backButtonColor,
                      size: 26,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(widget.title??'',
                    style: TextStyle(color: backButtonColor,fontSize: 20),
                    ),
                  )
                )
              ],
            ),
          ),
        );
    }

    return Scaffold(
      body: Column(
        children:<Widget>[
          _appBar(Color(int.parse('0xff'+statusBarColorStr)),backButtonColor),
          Expanded(
            child: WebviewScaffold(url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              // 加载时显示的内容
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('waiting'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}