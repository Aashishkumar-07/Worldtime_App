import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? time;
  String? url;
  String? flag;
  String? location;
  bool? isDaytime;

  WorldTime({this.location, this.flag, this.url});
  Future<void> getTime() async {
    try {
      var link = Uri.parse('http://worldtimeapi.org/api/timezone/$url');
      Response response = await get(link);
      Map data = jsonDecode(response.body);

      String offset_symbol = data['utc_offset'].substring(0, 1);
      String offset_hour = data['utc_offset'].substring(1, 3);
      String offset_min = data['utc_offset'].substring(4, 6);
      // print(offset_symbol);
      // print(offset_hour);

      DateTime now = DateTime.parse(data['utc_datetime']);

      if (offset_symbol == '-') {
        now = now.subtract(Duration(
            hours: int.parse(offset_hour), minutes: int.parse(offset_min)));
      } else {
        now = now.add(Duration(
            hours: int.parse(offset_hour), minutes: int.parse(offset_min)));
      }

      // print(now);
      isDaytime = now.hour > 5 && now.hour < 15 ? true : false;
      print(isDaytime);
      time = now.toString();
      time = DateFormat.jm().format(now);
    } catch (e) {
      print(e);
    }
  }
}
