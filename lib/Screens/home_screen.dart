import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;
import '../services/api_service.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/input_field.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _messages = [];
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _initializeConversation();
  }

  Future<void> _initializeConversation() async {
    try {
      final response = await _apiService.getTherapyResponse("Hello");
      setState(() {
        _messages.add({'sender': 'AI', 'text': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'AI', 'text': 'Error occurred'});
      });
    }
  }

  void _sendMessage(String text) async {
    setState(() {
      _messages.add({'sender': 'USER', 'text': text});
    });

    try {
      final response = await _apiService.getTherapyResponse(text);
      setState(() {
        _messages.add({'sender': 'AI', 'text': response});
      });
    } catch (e) {
      setState(() {
        _messages.add({'sender': 'AI', 'text': 'Error occurred'});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the AppBar invisible
        elevation: 0, // Remove shadow
        toolbarHeight: 0, // Set height to zero
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2D2D2D), Color(0xFF1C1C1C)], // Grey to dark grey gradient
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 80), // Ensure space for InputField
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        text: _messages[index]["text"]!,
                        isUser: _messages[index]["sender"] == "USER",
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: InputField(onSubmit: _sendMessage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
