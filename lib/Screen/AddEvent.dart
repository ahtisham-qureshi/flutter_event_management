import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Event.dart'; // Make sure this path is correct based on your folder structure

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  // 1. Declare controllers securely
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    // 2. Prevent memory leaks!
    _eventNameController.dispose();
    _dateController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // 3. The Native Date Picker Function
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

  // 4. Submit Function
  void addEvent() {
    // Prevent submitting if crucial fields are empty
    if (_eventNameController.text.isEmpty || _dateController.text.isEmpty) {
      // Pro-tip: You could show a SnackBar here telling the user to fill all fields!
      return;
    }

    // Create the strongly-typed Event object
    Event newEvent = Event(
      title: _eventNameController.text,
      date: _dateController.text,
      location: _locationController.text,
    );

    // Pop the screen and pass the new event BACK to the Home screen
    Navigator.pop(context, newEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10172A), // Brand Dark Background

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add New Event",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Event Name Field
            _buildTextField(
              controller: _eventNameController,
              hintText: "Event Name",
              icon: Icons.event,
              iconColor: const Color(0xFFFF1493), // Neon Pink
            ),
            const SizedBox(height: 20),

            // Date Field (Uses the Date Picker!)
            _buildTextField(
              controller: _dateController,
              hintText: "Event Date",
              icon: Icons.calendar_month,
              iconColor: const Color(0xFF8A2BE2), // Purple
              readOnly: true, // Stops the keyboard from appearing
              onTap: () => _selectDate(context), // Opens the calendar
            ),
            const SizedBox(height: 20),

            // Location Field
            _buildTextField(
              controller: _locationController,
              hintText: "Location",
              icon: Icons.location_on,
              iconColor: const Color(0xFF0066FF), // Blue
            ),
            const SizedBox(height: 40),

            // Add Event Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF1493),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: addEvent,
                child: Text(
                  "Add Event",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Clean Helper Method for TextFields
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required Color iconColor,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      style: GoogleFonts.poppins(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1E293B), // Elevated card color
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.white54),
        prefixIcon: Icon(icon, color: iconColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFFF1493), width: 2),
        ),
      ),
    );
  }
}
