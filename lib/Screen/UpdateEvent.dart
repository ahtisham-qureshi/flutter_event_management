import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Event.dart';

class UpdateEvent extends StatefulWidget {
  const UpdateEvent({super.key, required this.data, required this.index});

  final List<Event> data;
  final int index;

  @override
  State<UpdateEvent> createState() => _UpdateEventState();
}

class _UpdateEventState extends State<UpdateEvent> {
  // 1. Declare controllers securely outside the build method
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    // 2. Initialize them exactly ONCE when the screen loads [cite: 125]
    final currentEvent = widget.data[widget.index];
    _titleController = TextEditingController(text: currentEvent.title);
    _dateController = TextEditingController(text: currentEvent.date);
    _locationController = TextEditingController(text: currentEvent.location);
  }

  @override
  void dispose() {
    // 3. Destroy them when the screen closes to prevent memory leaks [cite: 126]
    _titleController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Prevents picking past dates
      lastDate: DateTime(2030),
      builder: (context, child) {
        // Theme the calendar to match your brand
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFFF1493), // Neon Pink header
              onPrimary: Colors.white,
              surface: Color(0xFF1E293B), // Dark slate background
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        // Format: YYYY-MM-DD
        _dateController.text =
            "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Brand Guide: Sleek Dark Background [cite: 101]
      backgroundColor: const Color(0xFF10172A),

      appBar: AppBar(
        title: Text(
          "Update Event",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent, // Keeps the dark theme flowing
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ), // Makes the back arrow white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputLabel("Title:"),
            _buildTextField(_titleController),
            const SizedBox(height: 20),

            _buildInputLabel("Date:"),
            _buildTextField(
              _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 20),

            _buildInputLabel("Location:"),
            _buildTextField(_locationController),
            const SizedBox(height: 40),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isEmpty ||
                      _dateController.text.isEmpty) {
                    // Pro-tip: You could show a SnackBar here telling the user to fill all fields!
                    return;
                  }
                  Event updatedEvent = Event(
                    title: _titleController.text,
                    date: _dateController.text,
                    location: _locationController.text,
                  );
                  Navigator.pop(context, updatedEvent);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(
                    0xFFFF1493,
                  ), // Brand Guide: Neon Pink [cite: 101]
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Submit",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.white70, // Slightly faded white for visual hierarchy
        ),
      ),
    );
  }

  // Helper method to make TextFields look premium on a dark background
  Widget _buildTextField(
    TextEditingController controller, {
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly, // Stops keyboard if true
      onTap: onTap,
      style: GoogleFonts.poppins(
        color: Colors.white,
      ), // Text typed by user is white
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(
          0xFF1E293B,
        ), // Elevated slate tint so it stands out from the background [cite: 104, 105]
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none, // Removes the ugly default underline
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFFF1493),
            width: 2,
          ), // Neon Pink border when tapped
        ),
      ),
    );
  }
}
