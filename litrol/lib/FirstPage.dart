import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert' show json, utf8;
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';


class First extends StatefulWidget {
  @override
  first createState()=>new first();
  }
class first extends State<First>
{  List list;

String Price=" ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrice();
    getChart();

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

    }    await apiRequest(url);}

    Future getChart()
    async {

      String url =
          'https://litrol.herokuapp.com/getlast7days';


      Future<String> apiRequest2(String url) async {


        var response = await http.get(
            url,
            headers:{ "Content-Type":"application/json" }
        );

        print(response.body);

         Map map=json.decode(response.body);
         list=map["Items"];
          print(list[0]["date"]["day"]);
        setState(() {

        });

        return "success";

      }

      await apiRequest2(url);

    }
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:<Widget>[new Expanded(flex:2,child:Container(
          margin: EdgeInsets.all(30.0),
      child: new Column(children: <Widget>[new Center(
        child: new Text('Todays price is '+Price,
        style: new TextStyle(

              fontSize: 25.0,
            ),
        )
      )]))),new Expanded(
      flex:5,
        child: CustomAxisTickFormatters (
    _createSampleData(list),
    // Disable animations for image tests.
    animate: false,

      ))]);
  }
}
class CustomAxisTickFormatters extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomAxisTickFormatters(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.


  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(seriesList,
        animate: animate,
        // Sets up a currency formatter for the measure axis.
        primaryMeasureAxis: new charts.NumericAxisSpec(
            tickFormatterSpec: new charts.BasicNumericTickFormatterSpec(
                new NumberFormat.currency(locale: 'hi-IN',decimalDigits:0))),

        /// Customizes the date tick formatter. It will print the day of month
        /// as the default format, but include the month and year if it
        /// transitions to a new month.
        ///
        /// minute, hour, day, month, and year are all provided by default and
        /// you can override them following this pattern.
        domainAxis: new charts.DateTimeAxisSpec(
            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec(
                    format: 'd', transitionFormat: 'MM/dd/yyyy'))));
  }
}
  /// Create one series with sample hard coded data.
 List<charts.Series<MyRow, DateTime>> _createSampleData(List lista) {
    List list=lista;
    int num=(double.parse(list[0]["price"])*100).round();


    print(num);
    final data = [

   new MyRow(new DateTime(list[0]["date"]["year"],list[0]["date"]["month"], list[0]["date"]["day"]),double.parse(list[0]["price"])),
      new MyRow(new DateTime(list[1]["date"]["year"],list[1]["date"]["month"], list[1]["date"]["day"]),double.parse(list[1]["price"])),
      new MyRow(new DateTime(list[2]["date"]["year"],list[2]["date"]["month"], list[2]["date"]["day"]),double.parse(list[2]["price"])),
      new MyRow(new DateTime(list[3]["date"]["year"],list[3]["date"]["month"], list[3]["date"]["day"]),double.parse(list[3]["price"])),
      new MyRow(new DateTime(list[4]["date"]["year"],list[4]["date"]["month"], list[4]["date"]["day"]),double.parse(list[4]["price"])),
      new MyRow(new DateTime(list[5]["date"]["year"],list[5]["date"]["month"], list[5]["date"]["day"]),double.parse(list[5]["price"])),
      new MyRow(new DateTime(list[6]["date"]["year"],list[6]["date"]["month"], list[6]["date"]["day"]),double.parse(list[6]["price"])),


      ];

    return [
      new charts.Series<MyRow, DateTime>(
        id: 'Cost',
        domainFn: (MyRow row, _) => row.timeStamp,
        measureFn: (MyRow row, _) => row.cost,
        data: data,
      )
    ];
  }


/// Sample time series data type.
class MyRow {
  final DateTime timeStamp;
  final double cost;
  MyRow(this.timeStamp, this.cost);
}