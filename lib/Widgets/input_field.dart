import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

class InputField extends StatefulWidget {
  final Function(String) onSubmit;
  final String hintText; // Add hintText parameter

  InputField({required this.onSubmit, this.hintText = "Type your response..."});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final TextEditingController _controller = TextEditingController();

  void _handleSubmitted() {
    String text = _controller.text;
    if (text.isNotEmpty) {
      widget.onSubmit(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final greyishBlack = Color(0xFF2C2C2C); // Greyish black color for background

    return Container(
      padding: EdgeInsets.all(8.0), // Padding around the entire container
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: greyishBlack,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0)), // Round only left corners
              ),
              child: TextField(
                controller: _controller,
                style: gf.GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  hintText: widget.hintText, // Use hintText parameter
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  border: InputBorder.none, // Remove the border
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0), // Internal padding
                ),
                onSubmitted: (_) => _handleSubmitted(),
              ),
            ),
          ),
          SizedBox(width: 0.0), // No extra space between TextField and button
          Container(
            decoration: BoxDecoration(
              color: greyishBlack,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(30.0)), // Round only right corners
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: _handleSubmitted,
              padding: EdgeInsets.all(0), // Remove padding around the icon
              constraints: BoxConstraints(), // Remove constraints to avoid extra spacing
            ),
          ),
        ],
      ),
    );
  }
}
