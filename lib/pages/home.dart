import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  Map data = {};
  Home({super.key, required this.data});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Map data1 = {};

  @override
  Widget build(BuildContext context) {
    try {
      print(widget.data['time']);
      DateTime time = DateFormat.jm().parse(widget.data['time'] ?? "");
      int hour = time.hour;
      //print(widget.data);
      String day_night_bg;

      //if true(daytime) check if it is noon or early morn
      //if false(night) check if it is sunset or night
      day_night_bg = widget.data['isDaytime']
          ? hour < 10
              ? 'sunrise.png'
              : 'noon.png'
          : hour < 18
              ? 'sunset.png'
              : 'night.png';
      print(day_night_bg);
      dynamic notifi_panel_bg =
          widget.data['isDaytime'] ? Colors.grey : Colors.indigo[700];

      return Scaffold(
          //backgroundColor: notifi_panel_bg,

          body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/$day_night_bg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 150.0, 0, 0),
          child: Column(
            children: <Widget>[
              TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    setState(() {
                      widget.data = {
                        'time': result!['time'],
                        'location': result!['location'],
                        'isDaytime': result!['isDaytime'],
                        'flag': result!['flag']
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location),
                  label: Text('Edit Location')),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(widget.data['location'],
                      style: TextStyle(
                        fontSize: 33,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      )),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                widget.data['time'] ?? "NULL",
                style: TextStyle(
                  fontSize: 66.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ));
    } catch (e) {
      print("Error: $e");
      print("Stack Trace: ${e.toString()}");
    }
    return Container();
  }
}
