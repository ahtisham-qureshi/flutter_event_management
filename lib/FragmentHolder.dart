import 'package:flutter/material.dart';
import 'Screen/Splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screen/Home.dart';
import 'Screen/UpdateEvent.dart';
import 'Screen/Event.dart';
import 'Screen/AddEvent.dart';

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
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
  }

  void addEvent(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/add');

    if (result != null && result is Event) {
      data.add(result);
      setState(() {
        data = data;
      });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Navigator(
        initialRoute: '/',
        onGenerateRoute: (settings) {
          WidgetBuilder builder;
          switch (settings.name) {
            case '/':
            // builder = (BuildContext context) => Splash();
            // break;

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
