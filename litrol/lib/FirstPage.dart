import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert' show json, utf8;
import 'package:http/http.dart' as http;

class First extends StatefulWidget {
  @override
  first createState()=>new first();
  }
class first extends State<First>
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
        'https://litrol.herokuapp.com/getprice';


    Future<String> apiRequest(String url) async {


      var response = await http.get(
          url,
          headers:{ "Content-Type":"application/json" }
      );

      print(response.body);

      Map map=json.decode(response.body);

      setState(() {

       Price=map["Price"];
      });

      return "success";

    }
    await apiRequest(url);
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Center(
        child: new Text('Todays price is '+Price,
        style: new TextStyle(
              
              fontSize: 25.0,
            ),
        )
      )
    );
  }
}
