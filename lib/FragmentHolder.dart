import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screen/Home.dart';
import 'Screen/UpdateEvent.dart';

class FragmentHolder extends StatefulWidget {
  const FragmentHolder({super.key});

  @override
  State<FragmentHolder> createState() => _FragmentHolderState();
}

class _FragmentHolderState extends State<FragmentHolder> {
  final List<Map<String, dynamic>> data = [
    {"title": "Music Concert", "date": "20 May 2026", "location": "Ahmedabad"},
    {"title": "Tech Seminar", "date": "25 May 2026", "location": "Gandhinagar"},
    {"title": "College Fest", "date": "30 May 2026", "location": "Surat"},
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
              builder = (BuildContext context) => EventScreen(data: data);
            case '/home':
              builder = (BuildContext context) => EventScreen(data: data);
            case '/update':
              builder = (BuildContext context) => UpdateEvent(
                data: data,
                index: settings.arguments?["index"] ?? 0,
              );
            default:
              builder = (BuildContext context) => Text("Not Found!");
          }
          return MaterialPageRoute(builder: builder, settings: settings);
        },
      ),
    );
  }
}
