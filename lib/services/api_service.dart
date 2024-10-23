import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions';

  Future<String> getTherapyResponse(String userInput) async {
    final String apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';

    if (apiKey.isEmpty) {
      throw Exception('API Key is not set.');
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'model': 'ft:gpt-4o-mini-2024-07-18:personal:pandora:A40TIEIl', // or the specific model you want to use
        'messages': [
          {
            'role': 'system',
            'content': '''
              You are a supportive and empathetic therapy bot. Your role is to provide emotional support, advice, and comforting words to users. Follow these guidelines:
              1. start the conversation like a simple therapist.
              2. Keep responses genuine.
              3. Use positive language and provide actionable advice when possible.
              4. Do not diagnose or provide medical advice.But you can provide and ask questions regarding the issue if the user is willing to share their issue.
              5. Ensure user input stays within the context of emotional support and well-being.
              6. Don't chain a bunch of questions we have to give the user some kind of closure so when feeling like it provide the user with a closure statement
              7. if any text regarding self harm is observed ,give out suicide helpline number for INDIA.
              Example prompt: "User: I am feeling anxious about my upcoming exams."
              Example response: "It's natural to feel anxious about exams. Take a deep breath, break your study into smaller tasks, and remember to take breaks. You've got this!"
            '''
          },
          {'role': 'user', 'content': userInput},
        ],
        'max_tokens': 150,
        'temperature': 0.8,// Adjust the number of tokens as needed
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to connect. Status Code: ${response.statusCode}');
    }
  }
}
