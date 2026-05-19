import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Event.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key, required this.data});

  final List<Event> data;

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  // Mock data representing events

  void addEvent() {
    setState(() {
      widget.data.add(
        Event(title: "New Event", date: "01 June 2026", location: "Rajkot"),
      );
    });
  }

  void editEvent(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/update',
      arguments: {"index": index, "data": widget.data},
    );

    if (result != null && result is Event) {
      // 4. NOW we safely run setState to update the UI with the fresh data
      setState(() {
        widget.data[index] = result;
      });
    }
  }

  void deleteEvent(int index) {
    setState(() {
      widget.data.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    // The background color defaults to dark automatically if configured globally via ThemeData.
    // Explicit background styling is omitted here to let your unified theme shine through.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Events",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: addEvent,
              icon: const Icon(
                Icons.add_circle,
                size: 28,
                color: Color(0xFFFF1493),
              ), // Neon Pink Accent
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.data.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        itemBuilder: (context, index) {
          final event = widget.data[index];

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            color: const Color(
              0xFF1E293B,
            ), // Sleek, contrasting container slate background
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.white.withOpacity(0.05), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF1493).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.event,
                        color: Color(0xFFFF1493), // Neon Pink accent
                      ),
                    ),
                    title: Text(
                      event.title,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 14,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                event.date,
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                event.location,
                                style: GoogleFonts.poppins(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(color: Colors.white10, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () => editEvent(index),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(
                            0xFF38BDF8,
                          ), // Cyan/Ice blue text accent
                        ),
                        icon: const Icon(Icons.edit, size: 18),
                        label: Text(
                          "Edit",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton.icon(
                        onPressed: () => deleteEvent(index),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.redAccent.shade200,
                        ),
                        icon: const Icon(Icons.delete_outline, size: 18),
                        label: Text(
                          "Delete",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
