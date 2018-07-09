import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class Second extends StatefulWidget {
  @override
  second createState()=>new second();
}
class second extends State<Second>
{
  String Price=" ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrice();

  }
  Future getPrice()
  async {

    String url =
        'https://litrol.herokuapp.com/predict';


    Future<String> apiRequest(String url) async {


      var response = await http.get(
          url,
          headers:{ "Content-Type":"application/json" }
      );

      print(response.body);

      Map map=json.decode(response.body);

      setState(() {

        Price=map["Price"];
        Price=Price.substring(0,5);
      });

      return "success";

    }
    await apiRequest(url);
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text('Tomorrows price is '+Price,
        style: new TextStyle(
              
              fontSize: 25.0,
            ),
        )
      )
    );
  }
}