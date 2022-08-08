import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../helper/helpers.dart';
import '../../size_config.dart';

class MyFatoorahScreen extends StatefulWidget {
  static String routName = 'fatoorah';
  final String? url;
  const MyFatoorahScreen({Key? key, required this.url}) : super(key: key);

  @override
  _MyFatoorahScreenState createState() => _MyFatoorahScreenState();
}

class _MyFatoorahScreenState extends State<MyFatoorahScreen> {

  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    debugPrint(widget.url);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        title: header('${Utils.getTranslatedText(context, 'checkout')}'),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: widget.url,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (url) async{
                if (url.contains("callbackOrder") || url.contains("callbackService")) {
                  // var res = await get(Uri.parse(url));
                  // log(jsonDecode(res.body).toString());
                  // log('success ' + url.toString());
                  await Utils.showSnack('', '${Utils.getTranslatedText(context, 'invoice_hint')}', context, Colors.black);
                  Navigator.pop(context,'success');
                }else{
                  log('failed ' + url.toString());
                }
          },
        );
      }),
    );
  }

  Widget header(String text){
    return Text(text,style:
    TextStyle(color: Colors.black, fontSize: SizeConfig.blockSizeVertical! * 2,
        fontWeight: FontWeight.bold),textAlign: TextAlign.center,);
  }

}
