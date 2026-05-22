import 'dart:convert';

import 'package:flutter/material.dart';
import 'Screen/Splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screen/Home.dart';
import 'Screen/UpdateEvent.dart';
import 'Screen/Event.dart';
import 'Screen/AddEvent.dart';

class FragmentHolder extends StatefulWidget {
  FragmentHolder({super.key, required this.isNav});
  Function isNav;
  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  _FragmentHolderState() {
    preData();
  }

  List<Event> data = [
    Event(title: "Music Concert", date: "2026-05-30", location: "Ahmedabad"),
    Event(title: "Tech Seminar", date: "2026-05-25", location: "Gandhinagar"),
    Event(title: "College Fest", date: "2026-05-21", location: "Surat"),
  ];

  void deleteEvent(int index) {
    data.removeAt(index);
    setState(() {
      data = data;
    });
    saveData();
  }

  void addEvent(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add');

    if (result != null && result is Event) {
      data.add(result);
      setState(() {
        data = data;
      });
      saveData();
    }
  }

  void editEvent(BuildContext context, int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/update',
      arguments: {"index": index, "data": data},
    );

    if (result != null && result is Event) {
      data[index] = result;
      setState(() {
        data = data;
      });
      saveData();
    }
  }

  Future<void> saveData() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      String jsonString = jsonEncode(data.map((e) => e.toJson()).toList());

      await pref.setString("Event_Info", jsonString);
      print('Error Free Code');
    } catch (e) {
      print('Error saving data : $e');
    }
  }

  Future<void> preData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('Event_Info');

    if (jsonString == null) {
      return;
    }

    List<dynamic> jsonMap = jsonDecode(jsonString);
    data = jsonMap.map((e) => Event.fromJson(e)).toList();
    setState(() {
      data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Navigator(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
              builder = (BuildContext context) => Splash(isNav: widget.isNav);
              break;

            case '/home':
              builder = (BuildContext context) => EventScreen(
                data: data,
                deleteEvent: deleteEvent,
                addEvent: addEvent,
                editEvent: editEvent,
              );
              break;

            case '/update':
              builder = (BuildContext context) => UpdateEvent(
                data: data,
                index: (settings.arguments as Map)["index"],
              );
              break;

            case '/add':
              builder = (BuildContext context) => AddEventScreen();
              break;

            default:
              builder = (BuildContext context) =>
                  const Scaffold(body: Center(child: Text("Not Found!")));
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
