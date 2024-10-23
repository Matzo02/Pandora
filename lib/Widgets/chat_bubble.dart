import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatBubble({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    // Define the max width for user bubbles
    final maxWidth = MediaQuery.of(context).size.width * 0.75;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Show CircleAvatar only if it's not the user
          if (!isUser)
            CircleAvatar(
              child: Icon(Icons.android, color: Colors.white),
              backgroundColor: Colors.green,
            ),
          SizedBox(width: 10.0),
          // Chat bubble container
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth, // Limit the width of the chat bubble
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              decoration: BoxDecoration(
                color: isUser ? Colors.blueGrey[800] : Colors.grey[900], // Dark matte colors
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                text,
                style: gf.GoogleFonts.poppins(color: Colors.white),
                softWrap: true, // Allow text to wrap
              ),
            ),
          ),
          SizedBox(width: 10.0),
          // Show CircleAvatar only if it's the user
          if (isUser)
            CircleAvatar(
              child: Icon(Icons.person, color: Colors.white),
              backgroundColor: Colors.blue,
            ),
        ],
      ),
    );
  }
}
