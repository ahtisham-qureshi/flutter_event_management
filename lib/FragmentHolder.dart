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
  final List<Event> data = [
    Event(title: "Music Concert", date: "20 May 2026", location: "Ahmedabad"),
    Event(title: "Tech Seminar", date: "25 May 2026", location: "Gandhinagar"),
    Event(title: "College Fest", date: "30 May 2026", location: "Surat"),
  ];
  @override
  Widget build(BuildContext context) {
    // switch (settings.name) {
    //   case "/home":
    //       builder = (BuildContext context) => const EventScreen(data: data)
    //   case "/update":
    //       builder = (BuildContext context) => const UpdateEvent(data: data, index: 0)
    //   default:
    // }
    // return MaterialPageRoute(builder: builder, settings: settings)
    // );
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
              builder = (BuildContext context) => EventScreen(data: data);
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
